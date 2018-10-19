<template>
<ul class="desktop">
    <li v-for="(table,index) in tables" :key="index" @click="openTable(table)">
        {{table}}
    </li>
</ul>
</template>

<script>
export default {
  name: "desk-app",
  data() {
    return {
      tables: [1, 2, 3, 4, 5, 6, 7, 8, 9],
      selectTable: 0,
      orderId: 0
    };
  },
  methods: {
    printUrl() {
      alert(
        `192.168.1.216/table/public/table/${this.selectTable}/orderid/${
          this.orderId
        }`
      );
    },
    openTable(table) {
      this.selectTable = table;
      axios
        .post("api/opentable", { table_number: this.selectTable })
        .then(res => {
          this.orderId = res.data.orderId;
        })
        .then(res => {
          this.printUrl();
        });
    }
  }
};
</script>
<style lang="scss" scoped>
ul {
  display: grid;
  list-style-type: none;
  padding: 10px;
  grid-template-columns: auto auto auto;
  li {
    background-color: rgba(255, 255, 255, 0.8);
    border: 1px solid rgba(0, 0, 0, 0.8);
    padding: 20px;
    font-size: 30px;
    text-align: center;
  }
}
</style>
