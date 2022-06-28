import Sortable from "sortablejs"

const Drag = {
    mounted() {
        const hook = this;
        const selector = "#" + hook.el.id;
        const dropzone = document.getElementById(hook.el.id)

        new Sortable(dropzone, {
            group: 'shared',
            draggable: '.draggable',
            onEnd: function(evt) {
                console.log(evt)
                hook.pushEventTo(selector, 'dropped', {
                    order_id: evt.item.id,
                    new_status: evt.to.id,
                    old_status: evt.from.id,
                })
            }
        });
    }
}

export default Drag;