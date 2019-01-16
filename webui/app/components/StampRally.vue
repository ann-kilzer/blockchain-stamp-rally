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
      <v-container class="primary lighten-3">
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
  export default {
    name: 'stampRally',
    data() {
      return {
        emptyURL: "http://placekitten.com/200/200",
        stamps: [],
        numStamps: 12,
        settingsPanel: false,
        address: "",
        unlinked: true,
        stampRally: null
      }
    },
    created() {
      this.setup()
    },
    methods: {
      setup() {
        for (var i = 0; i < this.numStamps; i++) {
          let blankStamp = {
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
        stamp.collectForm = false;
        console.log("Passphrase is " + stamp.passphrase)
        // todo
        stamp.passphrase = "";
      },
      async linkContract() {
        console.log("link contract");
        // todo
        try {
          // todo: link to contract instance
          this.settingsPanel = false;
          this.unlinked = false;
        } catch (e) {
          console.error(e)
        }
      }
    }
  }
</script>
