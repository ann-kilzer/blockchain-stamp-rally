<template>
  <v-container>
    <v-card>
      <v-toolbar color="primary" dark>
        <v-toolbar-title>Blockchain Stamp Rally</v-toolbar-title>
      </v-toolbar>
      <v-container>
        <v-layout row>
          <v-flex v-for="stamp in stamps" :key=stamp md4 pa-3>
            <v-card>
              <v-container><v-layout column justify-center>
              <v-img src="http://placekitten.com/200/200"></v-img>
              <v-btn color="secondary" class="mt-4">Collect Stamp</v-btn>
              </v-layout></v-container>
            </v-card>
          </v-flex>
        </v-layout>
      </v-container>
    </v-card>
  </v-container>
  
</template>

<script>
  export default {
    name: 'stampRally',
    data() {
      return {
        stamps: [1, 2, 3]
      }
    }
  }
</script>
