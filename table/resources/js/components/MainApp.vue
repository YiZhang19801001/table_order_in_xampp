<template>
<div>
      <div v-if="spinnerShow" class="spinner-container">
          <svg class="spinner" width="65px" height="65px" viewBox="0 0 66 66" xmlns="http://www.w3.org/2000/svg">
              <circle class="path" fill="none" stroke-width="6" stroke-linecap="round" cx="33" cy="33" r="30"></circle>
          </svg>
      </div>

  <router-view></router-view>
</div>
</template>


<script>
import { mapGetters, mapActions, mapState, mapMutations } from "vuex";

export default {
  name: "main-app",

  computed: {
    ...mapGetters([
      "spinnerShow",
      "orderList",
      "orderId",
      "cdt",
      "v",
      "site",
      "table_number"
    ])
  },
  mounted() {
    this.setOrderId(this.$route.params.orderid);
    this.setTableNumber(this.$route.params.table);
    this.setCdt(this.$route.query.cdt);
    this.setV(this.$route.query.v);
    this.setAppConfig();
    this.updateOrderList();
    /**set channel to listen */
    Echo.channel("tableOrder").listen("newOrderItemAdded", e => {
      if (this.orderId === e.orderId) {
        this.updateOrderList();
      }
    }); /**first args is the event we gonna to listen to, second args is event itself */
  },
  methods: {
    ...mapActions([
      "replaceList",
      "setOrderId",
      "setTableNumber",
      "setCdt",
      "setV",
      "setAppConfig",
      "setSpinnerStatus"
    ]),
    updateOrderList() {
      this.setSpinnerStatus(true);
      axios
        .post("/table/public/api/initcart", {
          order_id: this.orderId,
          cdt: this.cdt,
          v: this.v,
          table_id: this.table_number
        })
        .then(res => {
          this.replaceList(res.data);
          this.setSpinnerStatus(false);
        });
    }
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
  z-index: 100000000;
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
</style>

