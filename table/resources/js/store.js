export default {
    state: {
        categoryList: [],
        productList: [],
        orderList: [],
        totalQuantityOfOrder: 0,
        totalPriceOfOrder: 0,
        spinnerShow: false,
        orderId: 0,
        table_number: 0,
        pathFrom: "",
        scrollPositionId: 0
    },
    getters: {
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
                sum = sum + el.item.price * el.quantity;
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
            }`;
        },
        scrollPositionId: state => {
            return state.scrollPositionId;
        }
    },
    mutations: {
        updateCategoryList(state, payload) {
            state.categoryList = payload;
        },
        updateProductList(state, payload) {
            state.productList = payload;
        },
        updateOrderList(state, payload) {
            state.orderList = payload;
        },
        AddNewItemToOrderList(state, payload) {
            /** ToDo: change the feature implements process, now just send this new_item to controller let server side determine change the database record or not, and return new order list */
            axios.post("/table/public/api/orderitem", {
                orderItem: payload,
                orderId: state.orderId
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
        }
    },

    actions: {
        getCategoryList(context) {
            axios.get("/table/public/api/categories").then(res => {
                context.commit("updateCategoryList", res.data.categories);
            });
        },
        getProductList(context) {
            context.commit("toggleSpinner", true);
            axios.get("/table/public/api/products").then(res => {
                context.commit("updateProductList", res.data.products);
                context.commit("toggleSpinner", false);
            });
        },
        addNewItemToOrderList(context, newItem) {
            context.commit("toggleSpinner", true);
            context.commit("AddNewItemToOrderList", newItem);
            context.commit("toggleSpinner", false);
        },
        increaseItemQuantityInOrderList(context, newItem) {
            context.commit("toggleSpinner", true);
            context.commit("IncreaseItemQuantityInOrderList", newItem);
            context.commit("toggleSpinner", false);
        },

        decreaseItemQuantityInOrderList(context, newItem) {
            context.commit("toggleSpinner", true);
            context.commit("decreaseQuantity", newItem);
            context.commit("toggleSpinner", false);
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
        }
    }
};
