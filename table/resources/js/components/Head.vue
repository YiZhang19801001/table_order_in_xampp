<template>
    <h2>{{isEN?"Table":"桌号"}} {{table_number}}</h2>
</template>
<script>
import { mapGetters } from "vuex";
export default {
  computed: {
    ...mapGetters(["table_number", "isEN"])
  }
};
</script>


