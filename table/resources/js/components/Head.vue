<template>
<div class="header">
    <div class="languageSwitchButtonGroup">
    <span class="button-wrapper">
                <span @click="setToCN" class="languageButton" :class="{languageButtonInactive:lang!=1}">{{app_conf.lang_switch_cn}}</span>
                <span @click="setToEN" class="languageButton" :class="{languageButtonInactive:lang==1}">{{app_conf.lang_switch_en}}</span>
    </span>
    </div>
    <h2>{{app_conf.app_header_title}} {{table_number}}</h2>
</div>
</template>

<script>
import { mapGetters, mapActions } from "vuex";
export default {
  computed: {
    ...mapGetters(["table_number", "app_conf", "lang", "pathFrom"])
  },
  methods: {
    ...mapActions(["setLang"]),
    setToCN() {
      localStorage.language_id = 2;
      this.setLang(2);
      this.$router.go();
    },
    setToEN() {
      localStorage.language_id = 1;
      this.setLang(1);
      this.$router.go();
    }
  }
};
</script>

<style lang="scss" scoped>
.header {
  position: fixed;
  width: 100%;
  height: 8%;
  background-color: rgb(235, 77, 75);
  color: #f8fafc;
  //   padding: 6px;
  box-shadow: 0px 5px 5px #00000038;
  z-index: 200;
}
h2 {
  position: absolute;
  top: 10px;
  left: 38%;
  text-align: center;
  font-weight: bold;
  text-shadow: 2px 2px 6px #000;
}
/*language switch button :yin_yang:*/
.languageSwitchButtonGroup {
  text-align: right;
  padding-right: 20px;
  margin-top: 4px;
  .button-wrapper {
    box-shadow: 0px 0px 2px black;
  }
  .languageButton {
    padding: 3px;
    &.languageButtonInactive {
      background-color: #933b38;
      padding: 0px 5px;
      box-shadow: inset 0px 1px 1px rgba(0, 0, 0, 0.5);
    }
  }
}
</style>

