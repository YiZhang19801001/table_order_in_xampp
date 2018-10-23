<template>
<div class="header">
        <h2>Table {{table_number}}</h2>
</div>
</template>
<script>
import { mapGetters } from "vuex";
export default {
  computed: {
    ...mapGetters(["table_number"])
  }
};
</script>

<style lang="scss" scoped>
.header {
  position: fixed;
  width: 100%;
  height: 30px;
  background-color: rgba(147, 59, 56, 0.6);
  color: #f8fafc;
  //   padding: 6px;
  box-shadow: 0px 5px 5px #00000038;
  z-index: 200;
}
h2 {
  position: absolute;
  top: 10px;
  width: 100%;
  text-align: center;
  font-weight: bold;
  text-shadow: 2px 2px 6px #000;
}
</style>

