// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

import React from "react"
import ReactDOM from "react-dom"
import Axios from "axios"
import jQuery from "jquery"

class ChatInput extends React.Component {
  render() {
    return (

      <form className="form-mensajes" onSubmit = {this._handleSubmit.bind(this)}>
        <div className="inputs-mensajes">
          Nombre: <input type="text" placeholder="Eg. Pepito Perez" ref={(input) =>{this._nombre= input}}/>
          Mensaje:<input type="textarea" placeholder="Eg. Hola Mundo!" ref={(input) =>{this._body= input}}/>
        </div>


        <div className="btn-enviar-mensaje">
          <input type="submit" name="" value="Enviar"/>
        </div>
      </form>
    )
  }
  _handleSubmit(event){
    event.preventDefault();
    let n = this._nombre
    let b = this._body
    const mensaje = {name: n.value, body: b.value}

    let csrf = document.querySelector("meta[name=csrf]").content

    Axios({
      method: 'post',
      url: '/mensajes',
      data: {mensaje},
      headers: {
      "X-CSRF-TOKEN": csrf
      },
      dataType: "json"
    })
  }

}

class  ChatOutput extends React.Component{

  render(){
    return  (
      <div className="container">
        <ul className="list-group">
          <li className = "list-group-item-success">
            <h2> {this.props.mensaje.name}  said:</h2><p>{this.props.mensaje.body}</p>
            <button className="btn btn-warning" onClick={this._handleDelete.bind(this)}>Eliminar</button>

          </li>
        </ul>
      </div>
    )
  }

  _handleDelete(event){
    event.preventDefault()
    if (confirm('Are you sure?')) {
      this.props.onDelete(this.props.mensaje)
    }
  }
}



class Chat extends React.Component {
  constructor() {
    super();
    this.state={mensajes: []}
  }

  render(){
    const mensajes = this._getMensajes();
    return (
      <div className="panel panel-success">
        <div className="panel-heading">Comentarios</div>
        <div className="panel-body">
          <div className="container">
          </div>
          <ChatInput/>
          <div>{mensajes}</div>
        </div>
      </div>
    )
  }

  _getMensajes(){

    return this.state.mensajes.map((mensaje) => {
      console.log(mensaje);
      return <ChatOutput mensaje={mensaje} key={mensaje.id} onDelete={this._deleteMensaje.bind(this)}/>

    })
  }

  _deleteMensaje(mensaje){
    let csrf = document.querySelector("meta[name=csrf]").content

    Axios({
      method: 'delete',
      url: `/mensajes/${mensaje.id}`,
      headers: {
      "X-CSRF-TOKEN": csrf
      },
      dataType: "json"
    })
    const mensajes = [...this.state.mensajes];
    const mensajeIndex = mensajes.indexOf(mensaje);
    mensajes.splice(mensajeIndex,1);
    this.setState({mensajes});
  }

  _fetchMensajes(){
    Axios({
      method: 'get',
      url: '/mensajes'

    }).then(response => {
      let arreglo=response.data.data
      this.setState({mensajes: arreglo})
    })
  }

  componentWillMount(){
    this._fetchMensajes();
  }

  componentDidMount(){
    this._timer = setInterval(
      ()=>this._fetchMensajes(),
      5000
    );
  }

  componenWillUnmount(){
    clearInterval(this._timer)
  }

}

  ReactDOM.render(
    <Chat/>,
    document.getElementById("chat")
  )
