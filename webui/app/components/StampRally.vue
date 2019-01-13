<template>
  <v-container>
    <v-card>
      <v-toolbar color="primary" dark>
        <v-spacer></v-spacer>
        <v-toolbar-title>Blockchain Stamp Rally</v-toolbar-title>
        <v-spacer></v-spacer>
      </v-toolbar>
      <v-container>
        <v-layout v-bind="binding">
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
    },
    computed: {
      binding () {
        const binding = {}

        if (!this.$vuetify.breakpoint.mdAndUp) binding.column = true

        return binding
      }
    }
  }
</script>
