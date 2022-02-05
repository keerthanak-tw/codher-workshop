<template>
  <div v-if="isRedirectionPossible === '' || isRedirectionPossible === true">
    <q-linear-progress indeterminate />
  </div>
  <div v-if="isRedirectionPossible === false" class="row fixed-center">
    <q-img
        src="https://http.cat/404"
        style="width: 500px; height: 350px;"
        class="q-mr-lg"
    />
    <div class="column justify-center">
      <span class="text-h6">Seems like the ID you entered is wrong</span>
      <q-btn color="secondary" @click="$router.push('/')">Go To Home</q-btn>
    </div>
  </div>
</template>

<script>
import axios from "axios";
export default {
  name: 'RedirectPage',
  data() {
    return{
      isRedirectionPossible: ''
    }
  },
  async created() {
    try {
      const response = await axios.get(`https://ht9ojaxf3d.execute-api.ap-south-1.amazonaws.com/${this.$route.params.shortId}`);
      console.log(response);
      if (response.status === 200) {
        // window.location.href = response.data;
        this.isRedirectionPossible = true;
      }
      else {
        this.isRedirectionPossible = false;
      }
    } catch (e) {
      this.isRedirectionPossible = false;
    }
  }
}
</script>
