export default {
    state: {
        lang: 1,
        categoryList: [],
        productList: [],
        orderList: [],
        totalQuantityOfOrder: 0,
        totalPriceOfOrder: 0,
        spinnerShow: false,
        orderId: 0,
        table_number: 0,
        pathFrom: "",
        scrollPositionId: 0,
        cdt: "",
        v: "",
        site: 0,
        //ToDo: store_id, store_name, store_url should be generated automaticly.
        store_id: 4,
        store_name: "Monkey King Thai Restaurant",
        store_url: "http://192.168.1.221/",
        /**init config data */
        app_conf: {}
    },
    getters: {
        app_conf: state => {
            return state.app_conf;
        },
        lang: state => {
            return state.lang;
        },
        site: state => {
            return state.site;
        },
        cdt: state => {
            return state.cdt;
        },
        v: state => {
            return state.v;
        },
        store_id: state => {
            return state.store_id;
        },
        store_name: state => {
            return state.store_name;
        },
        store_url: state => {
            return state.store_url;
        },
        categoryList: state => {
            return state.categoryList;
        },
        productList: state => {
            return state.productList;
        },
        orderList: state => {
            return state.orderList;
        },
        totalQuantityOfOrder: state => {
            let sum = 0;

            state.orderList.forEach(el => {
                sum = sum + el.quantity;
            });
            return sum;
        },
        totalPriceOfOrder: state => {
            let sum = 0;

            state.orderList.forEach(el => {
                let option_sum = 0;
                if (state.app_conf.show_option) {
                    el.item.options.forEach(option => {
                        option_sum += option.price;
                    });
                }
                sum += el.quantity * (parseFloat(el.item.price) + option_sum);
            });
            return sum.toFixed(2);
        },
        spinnerShow: state => {
            return state.spinnerShow;
        },
        orderId: state => {
            return state.orderId;
        },
        table_number: state => {
            return state.table_number;
        },
        pathFrom: state => {
            return `/table/public/table/${state.table_number}/orderid/${
                state.orderId
            }?cdt=${state.cdt}&v=${state.v}`;
        },
        scrollPositionId: state => {
            return state.scrollPositionId;
        }
    },
    mutations: {
        updateLang(state, payload) {
            state.lang = payload;
        },
        updateApp_conf(state) {
            axios.get("/table/public/api/init/" + state.lang).then(res => {
                state.app_conf = res.data.app_conf;
            });
        },
        updateIsEN(state, payload) {
            state.isEN = payload;
        },
        updateCdt(state, payload) {
            state.cdt = payload;
        },
        updateV(state, payload) {
            state.v = payload;
        },
        updateProductList(state) {
            state.spinnerShow = true;
            axios.get("/table/public/api/products/" + state.lang).then(res => {
                state.productList = res.data.products;
                state.spinnerShow = false;
            });
        },
        updateOrderList(state, payload) {
            state.orderList = payload;
        },
        AddNewItemToOrderList(state, payload) {
            /** ToDo: change the feature implements process, now just send this new_item to controller let server side determine change the database record or not, and return new order list */
            axios.post("/table/public/api/orderitem", {
                orderItem: payload,
                orderId: state.orderId,
                table_id: state.table_number,
                lang: state.lang
            });
        },
        IncreaseItemQuantityInOrderList(state, newItem) {
            axios.post("/table/public/api/increase", {
                orderItem: newItem,
                orderId: state.orderId
            });
        },
        RemoveItemFromOrderList(state, newItem) {
            state.orderList.splice(state.orderList.indexOf(newItem), 1);
        },
        toggleSpinner(state, status) {
            state.spinnerShow = status;
        },
        updateOrderId(state, payload) {
            state.orderId = payload;
        },
        updateTableNumber(state, payload) {
            state.table_number = payload;
        },
        decreaseQuantity(state, payload) {
            axios.post("/table/public/api/decrease", {
                orderItem: payload,
                orderId: state.orderId
            });
        },
        updateScrollPositionId(state, newId) {
            state.scrollPositionId = newId;
        },
        updateCategoryList(state) {
            axios
                .get("/table/public/api/categories/" + state.lang)
                .then(res => {
                    state.categoryList = res.data.categories;
                });
        }
    },

    actions: {
        setLang(context, newStatus) {
            context.commit("updateLang", newStatus);
        },
        setAppConfig(context) {
            context.commit("updateApp_conf");
        },
        getCategoryList(context) {
            context.commit("updateCategoryList");
        },
        getProductList(context) {
            context.commit("updateProductList");
        },
        setSpinnerStatus(context, status) {
            context.commit("toggleSpinner", status);
        },
        addNewItemToOrderList(context, newItem) {
            context.commit("AddNewItemToOrderList", newItem);
        },
        increaseItemQuantityInOrderList(context, newItem) {
            context.commit("IncreaseItemQuantityInOrderList", newItem);
        },

        decreaseItemQuantityInOrderList(context, newItem) {
            context.commit("decreaseQuantity", newItem);
        },
        removeItemFromOrderList(context, newItem) {
            context.commit("RemoveItemFromOrderList", newItem);
        },
        setOrderId(context, newOrderId) {
            context.commit("updateOrderId", newOrderId);
        },
        setTableNumber(context, newTableNumber) {
            context.commit("updateTableNumber", newTableNumber);
        },
        replaceList(context, newList) {
            context.commit("updateOrderList", newList);
        },
        setScrollPositionId(context, newId) {
            context.commit("updateScrollPositionId", newId);
        },
        setCdt(context, newCdt) {
            context.commit("updateCdt", newCdt);
        },
        setV(context, newV) {
            context.commit("updateV", newV);
        },
        setIsEN(context, newStatus) {
            context.commit("updateIsEN", newStatus);
        },
        setFormClass(context, newClass) {
            context.commit("updateFormClass", newClass);
        }
    }
};
