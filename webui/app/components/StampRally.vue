<template>
  <div class="secondary">
  <v-container>
    <v-card>
      <v-toolbar color="primary" dark>
        <v-spacer></v-spacer>
        <v-toolbar-title>Blockchain Stamp Rally</v-toolbar-title>
        <v-spacer></v-spacer>
        <v-badge color="accent" overlap v-model="unlinked">
          <span slot="badge">!</span>
          <v-btn icon @click="settingsPanel = true"><v-icon>settings</v-icon></v-btn>
        </v-badge>
      </v-toolbar>
      <v-expand-transition>
        <v-container v-if="settingsPanel">
          <v-form>
            <v-text-field
              label="Contract Address"
              v-model="address"
              :rules="[() => !!address || 'Address is required']"
              required
              class="mb-2">
            </v-text-field>
            <v-btn 
                  color="accent" 
                  @click="linkContract()"
                  :disabled="address ==''"
                  >Link
                </v-btn>
            <v-btn @click="settingsPanel = false">Cancel</v-btn>
          </v-form>
        </v-container>
      </v-expand-transition>
      <!-- No Stamps-->
      <v-container v-if="numStamps == 0" class="primary lighten-3">
        <div class="title font-weight-light">No Contract linked, or contract has no stamps to collect. 
          Please set a valid contract address under settings.
        </div>
      </v-container>
      <v-container v-else class="primary lighten-3">
        <v-layout wrap justify-space-around>
          <v-flex v-for="(stamp, index) in stamps" :key=index xs12 md6 lg4 pa-3>
            <v-card>
              <v-container><v-layout column justify-center>
              <v-img :src="getURL(stamp)"></v-img>
              <v-btn 
                color="primary" 
                class="mt-4" 
                v-if="!stamp.collectForm && stamp.url == null" 
                @click="collectStamp(stamp)"
                block
                >Collect Stamp
              </v-btn>
              <!--Submit passphrase-->
              <v-card-actions v-else-if="stamp.url== null" class="justify-center"><v-form>
                <v-text-field 
                  label="Passphrase" 
                  v-model="stamp.passphrase"
                  :rules="[() => !!stamp.passphrase || 'Passphrase is required']"
                  required
                  class="mb-2">
                  </v-text-field>
                <v-btn 
                  color="accent" 
                  @click="submitPassphrase(stamp)"
                  :disabled="stamp.passphrase ==''"
                  >Submit
                </v-btn>
                <v-btn @click="stamp.collectForm = false">Cancel</v-btn>
              </v-form></v-card-actions>
              <!-- the void -->
              <v-container v-else class="mb-3"></v-container>
              </v-layout></v-container>
            </v-card>
          </v-flex>
        </v-layout>
      </v-container>
    </v-card>
  </v-container>
  </div>
</template>

<script>
  import Web3 from 'web3'

  export default {
    name: 'stampRally',
    data() {
      return {
        web3: null,
        contract: null,
        emptyURL: "http://placekitten.com/200/200",
        stamps: [],
        numStamps: 0,
        settingsPanel: false,
        address: "0x2bC4507106702ef5EAD0055AA0e5F8D2A9389499",
        unlinked: true,
        stampRally: null
      }
    },
    beforeMount() {
      this.setupWeb3()
    },
    created() {

    },
    methods: {
      setupPage() {
        for (var i = 0; i < this.numStamps; i++) {
          let blankStamp = {
            index: i,
            url: null,
            collectForm: false,
            passphrase: ""
          };
          this.stamps.push(blankStamp);
        }
      },
      getURL(stamp) {
        return (stamp.url) ? stamp.url : this.emptyURL;
      },
      collectStamp(stamp) {
        stamp.collectForm = true;
      },
      submitPassphrase(stamp) {
        let that = this;
        stamp.collectForm = false;
        console.log("Passphrase is " + stamp.passphrase)
        
        try {
          this.contract.methods.collectStamp(stamp.index, stamp.passphrase).call((err, result) => {
            if (err) {
              console.error(err)
              return
            }

            console.log(result)
          }).then(function() {
            that.updateStamp(stamp)
          })
        } catch(e) {
          console.error(e)
        }

        stamp.passphrase = "";
      },
      async updateStamp(stamp) {
        this.contract.methods.getStampImage(stamp.index).call((err, URL) => {
          if (err) {
            console.error(err)
              return
            }

          if (URL != "") {
            console.log("Updating stamp")
            stamp.url = URL
          } else {
            console.log("No stamp found")
          }  
        })
      },
      async linkContract() {
        console.log("link contract");
        let that = this;
        try {
          this.contract = new this.web3.eth.Contract(this.$root.json.abi, this.address);

          this.contract.methods.numStamps().call((err, numStamps) => { 
            if (err) {
              console.error(err)
              return
            }
            
            that.numStamps = numStamps
            that.setupPage()
          })

          this.settingsPanel = false;
          this.unlinked = false;
        } catch (e) {
          console.error(e)
        }
      },
      setupWeb3() {
        if (typeof window.web3 !== 'undefined') {
          this.web3 = new Web3(window.web3.currentProvider);
        } else {
          // set the provider you want from Web3.providers
          console.log('No web3 found. Falling back to Mist 🌫️ or MetaMask 🦊')
          this.web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));
        }
      }
    }
  }
</script>
