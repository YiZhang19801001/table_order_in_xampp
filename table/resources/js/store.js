export default {
    state: {
        categoryList: [],
        productList: [],
        orderList: [],
        totalQuantityOfOrder: 0,
        totalPriceOfOrder: 0,
        spinnerShow: false,
        orderId: 0,
        table_number: 0
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
        toggleSpinner(state) {
            state.spinnerShow = !state.spinnerShow;
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
        }
    },

    actions: {
        getCategoryList(context) {
            axios.get("/table/public/api/categories").then(res => {
                context.commit("updateCategoryList", res.data.categories);
            });
        },
        getProductList(context) {
            context.commit("toggleSpinner");
            axios.get("/table/public/api/products").then(res => {
                context.commit("updateProductList", res.data.products);
                context.commit("toggleSpinner");
            });
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
        }
    }
};
