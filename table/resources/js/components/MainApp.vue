<template>
<div>
    <div v-if="spinnerShow" class="spinner-container">
        <svg class="spinner" width="65px" height="65px" viewBox="0 0 66 66" xmlns="http://www.w3.org/2000/svg">
   <circle class="path" fill="none" stroke-width="6" stroke-linecap="round" cx="33" cy="33" r="30"></circle>
</svg>
    </div>
    <Head class="header"></Head>
    <div class="bodyContainer">
        <CategoryList></CategoryList>
        <ProductList></ProductList>
        <ShoppingCart></ShoppingCart>
    </div>
</div>
</template>


<script>
import CategoryList from "./CategoryList";
import ProductList from "./ProductList";
import ShoppingCart from "./ShoppingCart";
import Head from "./Head";
import { mapGetters, mapActions, mapState, mapMutations } from "vuex";

export default {
  name: "main-app",
  components: { CategoryList, ProductList, Head, ShoppingCart },
  computed: {
    ...mapGetters(["spinnerShow", "orderList", "orderId"])
  },
  mounted() {
    this.setOrderId(this.$route.params.orderid);
    this.setTableNumber(this.$route.params.table);
    console.log(this.orderId);
    axios
      .post("/table/public/api/initcart", { order_id: this.orderId })
      .then(res => {
        console.log(res.data);
        this.replaceList(res.data);
      });
    /**set channel to listen */
    Echo.channel("tableOrder").listen("newOrderItemAdded", e => {
      if (this.orderId === e.orderId) {
        axios
          .post("/table/public/api/initcart", { order_id: this.orderId })
          .then(res => {
            console.log(res.data);
            this.replaceList(res.data);
          });
      }
    }); /**first args is the event we gonna to listen to, second args is event itself */
  },
  methods: {
    ...mapActions(["replaceList", "setOrderId", "setTableNumber"])
  }
};
</script>

<style lang="scss" scoped>
$offset: 187;
$duration: 1s;
.spinner-container {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 100vh;
  width: 100vw;
  background-color: white;
  position: fixed;
  top: 0;
  left: 0;
}
.spinner {
  animation: rotator $duration linear infinite;
}

@keyframes rotator {
  0% {
    transform: rotate(0deg);
  }
  100% {
    transform: rotate(270deg);
  }
}

.path {
  stroke-dasharray: $offset;
  stroke-dashoffset: 180;
  transform-origin: center;
  animation: dash $duration ease-in-out infinite,
    colors ($duration * 4) ease-in-out infinite;
}

@keyframes colors {
  0% {
    stroke: #4285f4;
  }
  25% {
    stroke: #de3e35;
  }
  50% {
    stroke: #f7c223;
  }
  75% {
    stroke: #1b9a59;
  }
  100% {
    stroke: #4285f4;
  }
}

@keyframes dash {
  0% {
    stroke-dashoffset: $offset;
  }
  50% {
    stroke-dashoffset: $offset/4;
    transform: rotate(135deg);
  }
  100% {
    stroke-dashoffset: $offset;
    transform: rotate(450deg);
  }
}

.header {
  position: fixed;
  width: 100%;
  background-color: #f53b50;
  color: white;
  text-align: center;
  padding: 6px;
  box-shadow: 0px 5px 5px #00000038;
  z-index: 200;
}
.bodyContainer {
  display: flex;
  flex-direction: row;
}
</style>

