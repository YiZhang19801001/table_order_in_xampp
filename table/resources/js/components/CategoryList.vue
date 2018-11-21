<template>
    <div class="listContainer" v-scroll-spy-active v-scroll-spy-link>
        <div class="categoryContainer">
                <div v-for="(category,index) in categoryList" :key="index" class="categoryList"
                :class="{customActive:index===scrollPositionId}"
                @click="select(index)">
                   <a>{{category.name}}</a>
                </div>
        </div>
    </div>
</template>

<script>
import { mapGetters, mapMutations, mapActions, mapState } from "vuex";
export default {
  name: "app-category-list",
  computed: {
    ...mapGetters(["categoryList", "scrollPositionId"])
  },
  mounted() {
    this.$nextTick(() => this.getCategoryList());
  },
  methods: {
    ...mapMutations(["updateCategoryList"]),
    ...mapActions(["getCategoryList", "setScrollPositionId"]),
    select(index) {
      this.setScrollPositionId(index);
      //var name = $(this).attr("data-row-id");
      //var id = "#" + name;
      //var top = $(id).first().offset().top -60;
    }
  }
};
</script>

<style lang="scss" scoped>
.listContainer {
  justify-content: space-between;
  display: flex;
  height: 100%;
  width: 30%;
  flex-direction: column;
  position: relative;
  font-weight: bold;
  letter-spacing: 0.4px;
  //
  .categoryContainer {
    position: fixed;
    width: 30%;
    overflow: scroll;
    height: 80%;
    margin-top: 15%;
    margin-bottom: 15%;

    .categoryList {
      padding: 5px 10px;
      font-weight: 700;
      color: #000;
      border-bottom: 1px solid #80808026;
      transition: all 0.5s;
    }
    .customActive {
      color: #f8fafc;
      border-left: 4px solid #ffc24a;
      border-right: 4px solid #ffc24a;
      background-color: #eb4d4b;
      box-shadow: inset 0px 1px 3px rgba(0, 0, 0, 0.5);
      text-shadow: rgba(0, 0, 0, 0.8) 1px 1px 0px;
    }
  }
}
</style>

