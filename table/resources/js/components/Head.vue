<template>
    <h2>Table {{table_number}}</h2>
</template>
<script>
import { mapGetters } from "vuex";
export default {
  computed: {
    ...mapGetters(["table_number"])
  }
};
</script>


