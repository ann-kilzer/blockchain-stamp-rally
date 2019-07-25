<template>
  <div id="app">
    <stamp-rally />
  </div>
</template>


<script>
import StampRally from './components/StampRally.vue';

export default {
  name: 'app',
  components: {
    StampRally,
  },
};
</script>

<style>
#app{
    font-family: 'Roboto', sans-serif;
}
</style>
