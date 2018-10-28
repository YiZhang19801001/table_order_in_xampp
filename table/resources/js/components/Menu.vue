<template>
<div>

    <Head></Head>
    <div class="bodyContainer">
        <div v-if="show" class="header">
            <p class="close-button-wrap"><i class="material-icons" @click="close">close</i></p>
            <h2 class="warning-title">Your QRCode is invalid</h2>
            <p class="warning-message">please, contact staff before making order</p>
        </div>
        <CategoryList></CategoryList>
        <ProductList></ProductList>
    </div>
</div>

</template>

<script>
import CategoryList from "./CategoryList";
import ProductList from "./ProductList";
import { mapGetters, mapActions } from "vuex";
export default {
  name: "menu-app",
  data() {
    return {
      show: true
    };
  },
  components: { CategoryList, ProductList },
  computed: {
    ...mapGetters([
      "spinnerShow",
      "orderList",
      "orderId",
      "cdt",
      "v",
      "table_number"
    ])
  },
  mounted() {
    this.setOrderId("");
    this.setTableNumber(0);
    this.setCdt("");
    this.setV("");
  },
  methods: {
    ...mapActions([
      "setOrderId",
      "setTableNumber",
      "setCdt",
      "setV",
      "setSpinnerStatus"
    ]),
    close() {
      this.show = false;
    }
  }
};
</script>

<style lang="scss" scoped>
.bodyContainer {
  display: flex;
  flex-direction: row;
}
.header {
  position: fixed;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  top: 40%;
  left: 0;
  background-color: #f4b843;
  width: 100%;
  z-index: 500;
  padding: 10px;
  text-align: center;
  color: #e84848;
  text-shadow: 1px 1px 1px black;
  border-radius: 8px;
}
p.close-button-wrap {
  margin: 0;
  text-align: right;
}
</style>

