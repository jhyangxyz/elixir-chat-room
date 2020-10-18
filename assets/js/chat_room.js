import {Presence} from "phoenix"

const formatTimestamp = (Ts) => {
    let date = new Date(parseInt(Ts))
    return date.toLocaleString()
}

const listBy = (user, {metas: metas}) => {
    return {
        user: user,
        onlineAt: formatTimestamp(metas[0].online_at),
    }
}

let userList = document.getElementById("userList")

const render = (presences) => {
    let temp = Presence.list(presences, listBy);

    temp.forEach(temp => {
        console.log(temp)
    })
    userList.innerHTML = Presence.list(presences, listBy)
        .map(presence => `
            <li>
            ${presence.user}
            <small>online since ${presence.onlineAt.toLocaleString()}</small>
            </li>
        `)
}

let ChatRoom = {
    init(socket) {
        let channel = socket.channel('chat_room:lobby', {})

        channel.join()
            .receive("ok", resp => {console.log("Joined successfully")})
            .receive("error", resp => { console.log("Unable to join", resp) })

        this.listenForChats(channel)
    },

    listenForChats(channel) {
        document.getElementById('newMessageForm').addEventListener('submit', function(e){
            e.preventDefault()

            let userName = document.getElementById('user').innerText
            let userMsg = document.getElementById('newMessage').value

            channel.push('message:new', {name: userName, body: userMsg})

            // document.getElementById('user-name').value = ''
            document.getElementById('newMessage').value = ''
        })

        let presences = {};

        channel.on("presence_state", state => {
            presences = Presence.syncState(presences, state)
            render(presences)
        })

        channel.on("presence_diff", diff => {
            presences = Presence.syncDiff(presences, diff)
            render(presences)
        })

        channel.on('message:new', payload => {
            let chatBox = document.querySelector('#messageList')
            let msgBlock = document.createElement('li')

            msgBlock.insertAdjacentHTML('beforeend', `${payload.name}: ${payload.body}`)
            chatBox.appendChild(msgBlock)
        })

        // channel.on('user:joined', payload => {
        //     let chatBox = document.querySelector('#userList')
        //     let msgBlock = document.createElement('li')
        //
        //     msgBlock.insertAdjacentHTML('beforeend', `${payload.name}`)
        //     chatBox.appendChild(msgBlock)
        // })
    }
}

export default ChatRoom