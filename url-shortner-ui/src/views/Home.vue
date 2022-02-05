<template>
  <q-form
      ref="shortnerForm"
      class="q-gutter-md justify-center q-mt-lg wrap row"
      @submit="onSubmit"
      @reset="onReset"
  >
    <q-input
        class="input-field"
        v-model="inputUrl"
        label="Enter URL to be shortened *"
        :rules="[ val => val && val.length > 0 || 'Required']"
    />
    <q-btn
        color="secondary"
        class="home-button vertical-bottom"
        label="Get shortened URL"
        type="submit"
        no-caps
    />
    <q-btn
        color="white"
        class="home-button"
        text-color="black"
        label="Reset"
        type="reset"
        no-caps
    />
  </q-form>
  <div class="row justify-center">
    <q-input
        v-model="getShortenedURL"
        class="input-field"
        outlined
        placeholder="Shortened URL"
    >
      <template v-slot:append>
        <q-btn flat round icon="content_copy" @click="copyContent"/>
      </template>
    </q-input>
  </div>
</template>

<script>
import axios from 'axios';
import { copyToClipboard } from 'quasar';

export default {
  name: 'Home',
  data() {
    return {
      inputUrl: '',
      shortenedUrl: '',
    }
  },
  methods: {
    async onSubmit() {
      const data = {
        urlToShorten: this.inputUrl
      }
      const response = await axios.post('https://ht9ojaxf3d.execute-api.ap-south-1.amazonaws.com/shorten', data);
      this.shortenedUrl = response.data;
    },
    onReset() {
      this.inputUrl = '';
      this.shortenedUrl = '';
      this.$refs.shortnerForm.resetValidation();
    },
    copyContent() {
      copyToClipboard(this.getShortenedURL);
    }
  },
  computed: {
    getShortenedURL() {
      return this.shortenedUrl === '' ? '' : window.location.href + this.shortenedUrl;
    }
  }
}
</script>

<style>
.input-field {
  min-width: 60%;
}
.home-button {
  max-height: 40px;
}
</style>
