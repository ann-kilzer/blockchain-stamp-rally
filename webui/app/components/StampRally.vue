<template>
  <div class="secondary">
  <v-container>
    <v-card>
      <v-toolbar color="primary" dark>
        <v-spacer></v-spacer>
        <v-toolbar-title>Blockchain Stamp Rally</v-toolbar-title>
        <v-spacer></v-spacer>
      </v-toolbar>
      <v-container class="primary lighten-3">
        <v-layout wrap justify-space-around>
          <v-flex v-for="(stamp, index) in stamps" :key=index xs12 md6 lg4 pa-3>
            <v-card>
              <v-container><v-layout column justify-center>
              <v-img :src="getURL(stamp)"></v-img>
              <v-btn 
                color="primary" 
                class="mt-4" 
                v-if="!stamp.collectForm" 
                @click="collectStamp(stamp)"
                block
                >Collect Stamp
              </v-btn>
              <v-card-actions v-else class="justify-center"><v-form>
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
        numStamps: 12
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
      }
    }
  }
</script>
