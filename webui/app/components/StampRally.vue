<template>
  <v-container
    fluid
    class="secondary"
  >
    <v-layout
      align-start
      justify-center
      row
      fill-height
    >
      <v-card>
        <v-toolbar
          color="primary"
          dark
        >
          <v-spacer />
          <v-toolbar-title>{{ title }}</v-toolbar-title>
          <v-spacer />
          <v-badge
            v-model="unlinked"
            color="accent"
            overlap
          >
            <span slot="badge">!</span>
            <v-btn
              icon
              @click="settingsPanel = true"
            >
              <v-icon>settings</v-icon>
            </v-btn>
          </v-badge>
        </v-toolbar>
        <v-expand-transition>
          <v-container v-if="settingsPanel">
            <v-form>
              <v-text-field
                v-model="address"
                label="Contract Address"
                :rules="[() => !!address || 'Address is required']"
                required
                class="mb-2"
              />
              <v-btn 
                color="accent" 
                :disabled="address ==''"
                @click="linkContract()"
              >
                Link
              </v-btn>
              <v-btn @click="settingsPanel = false">
                Cancel
              </v-btn>
            </v-form>
          </v-container>
        </v-expand-transition>
        <!-- No Stamps-->
        <v-container
          v-if="numStamps == 0"
          class="primary lighten-3"
        >
          <div class="title font-weight-light">
            No Contract linked, or contract has no stamps to collect. 
            Please set a valid contract address under settings.
          </div>
        </v-container>
        <v-container
          v-else
          class="primary lighten-3"
        >
          <v-layout
            wrap
            justify-space-around
          >
            <v-flex
              v-for="(stamp, index) in stamps"
              :key="index"
              xs12
              md6
              lg4
              pa-3
            >
              <v-card>
                <v-container>
                  <v-layout
                    column
                    justify-center
                  >
                    <v-img :src="getURL(stamp)" />
                    <v-flex 
                      class="mt-3 text-xs-center" 
                    >
                      <span>{{ stamp.prompt }}</span>
                    </v-flex>
                    <v-btn 
                      v-if="!stamp.collectForm && stamp.url == null" 
                      color="primary" 
                      class="mt-3" 
                      block
                      @click="collectStamp(stamp)"
                    >
                      Collect Stamp
                    </v-btn>
                    <!--Submit passphrase-->
                    <v-card-actions
                      v-else-if="stamp.url== null"
                      class="justify-center"
                    >
                      <v-form>
                        <v-text-field 
                          v-model="stamp.passphrase" 
                          label="Passphrase"
                          :rules="[() => !!stamp.passphrase || 'Passphrase is required']"
                          required
                          class="mb-2"
                        />
                        <v-btn 
                          color="accent" 
                          :disabled="stamp.passphrase ==''"
                          @click="submitPassphrase(stamp)"
                        >
                          Submit
                        </v-btn>
                        <v-btn @click="stamp.collectForm = false">
                          Cancel
                        </v-btn>
                      </v-form>
                    </v-card-actions>
                    <!-- the void -->
                    <v-container
                      v-else
                      class="mb-3"
                    />
                  </v-layout>
                </v-container>
              </v-card>
            </v-flex>
          </v-layout>
        </v-container>
      </v-card>
    </v-layout>
  </v-container>
</template>

<script>
import Web3 from 'web3';

export default {
  name: 'StampRally',
  data() {
    return {
      web3: null,
      contract: null,
      emptyURL: window.location.origin + '/BlankStamp.jpg',
      stamps: [],
      numStamps: 0,
      settingsPanel: false,
      address: '',
      unlinked: true,
      stampRally: null,
      title: 'Blockchain Stamp Rally'
    };
  },
  beforeMount() {
    this.setupWeb3();
  },
  async created() {
    this.address = this.readCookie('address');
    await this.sleep(100); // TODO: timeouts are brittle. Figure out how to ensure web3 is properly initialized
    if (this.address !== '') {
      this.linkContract();
    }
  },
  methods: {
    sleep(ms) {
      return new Promise(resolve => setTimeout(resolve, ms));
    },
    setupPage() {
      this.stamps = [];
      for (var i = 0; i < this.numStamps; i++) {
        let blankStamp = {
          index: i,
          url: null,
          collectForm: false,
          passphrase: '',
          prompt: '...'
        };
        this.setPrompt(i),
        this.updateStamp(blankStamp);
        this.stamps.push(blankStamp);
      }
    },
    setPrompt(i) {
      this.contract.methods.getStampPrompt(i).call((err, prompt) => { 
        if (err) {
          console.error(err);
          return;
        }
        if (prompt !== '') {
          this.stamps[i].prompt = prompt;            
        }
      });
    },
    getURL(stamp) {
      return (stamp.url) ? stamp.url : this.emptyURL;
    },
    collectStamp(stamp) {
      stamp.collectForm = true;
    },
    async getActiveAccount() {
      let account;
      await this.web3.eth.getAccounts().then((response) => { 
        account = response[0];
      });
      return account;
    },
    async submitPassphrase(stamp) {
      console.log(stamp.passphrase);
      let that = this;
      stamp.collectForm = false;

      let sender = this.getActiveAccount();
      if (sender === undefined) {
        console.warn('No sender. Unable to collect stamp');
        return;
      }

      try {
        this.contract.methods.collectStamp(stamp.index, stamp.passphrase).send(
          {from: sender},
          (err, txHash) => {
            if (err) {
              console.error(err);
              return;
            }

            console.log('Transaction hash:', txHash);
          }).then(function() {
          that.updateStamp(stamp);
        });
      } catch(e) {
        console.error(e);
      }

      stamp.passphrase = '';
    },
    updateStamp(stamp) {
      this.contract.methods.getStampImage(stamp.index).call((err, URL) => {
        if (err) {
          console.error(err);
          return;
        }
        if (URL != '') {
          console.log('Updating stamp');
          stamp.url = URL;
        }
      });
    },
    async linkContract() {
      try {
        this.contract = new this.web3.eth.Contract(this.$root.json.abi, this.address);

        this.contract.methods.numStamps().call((err, numStamps) => { 
          if (err) {
            console.error(err);
            return;
          }
          if (numStamps == null) {
            console.error('Invalid response to numStamps()');
          } else {
            this.numStamps = numStamps;
            this.setupPage();
            this.settingsPanel = false;
            this.unlinked = false;
          }
        });

        this.contract.methods.name().call((err, name) => {
          if (err) {
            console.error(err);
            return;
          }
          if (name === null) {
            console.error('Invalid response to name()');
          } else {
            this.title = name;
          }
        });

        this.setCookie();

      } catch (e) {
        console.error(e);
      }
    },
    readCookie(name) {
      // modified from https://www.w3schools.com/js/js_cookies.asp
      const nameEq = name + '=';
      const decodedCookie = decodeURIComponent(document.cookie);
      const ca = decodedCookie.split(';');
      for(let i = 0; i <ca.length; i++) {
        let c = ca[i];
        // remove leading whitespace
        while (c.charAt(0) == ' ') {
          c = c.substring(1);
        }
        if (c.indexOf(nameEq) == 0) {
          return c.substring(nameEq.length, c.length);
        }
      }
      return '';
    },
    setCookie() {
      // Set a cookie so we can remember this contract later
      let d = new Date();
      d.setMonth(d.getMonth() + 3); 
      document.cookie = 'address=' + this.address + '; expires=' + d.toUTCString();
    },
    setupWeb3() {
      if (typeof window.web3 !== 'undefined') {
        this.web3 = new Web3(window.web3.currentProvider);
      } else {
        // set the provider you want from Web3.providers
        console.log('No web3 found. Falling back to Mist 🌫️ or MetaMask 🦊');
        this.web3 = new Web3(new Web3.providers.HttpProvider('http://localhost:8545'));
      }
    }
  }
};
</script>
