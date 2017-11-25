<template>
  <div>
    <animated-fade-in>
      <div id="title" >
        <h1>Opendata AIG Brazil</h1>
        <h2>Ocorrências Aeronáuticas na Aviação Civil Brasileira</h2>
      </div>
    </animated-fade-in>
    <animated-fade-in>
      <div id="description">
        <h3>Descrição</h3>
        <p>A base de dados de ocorrências aronáuticas é gerenciada pelo Centro de Investigação e Prevenção de Acidentes aeonáuticos (CENIPA).
          Constam nesta base de dados as ocorrências aeronáuticas notificadas ao CENIPA nos últimos 10 anos e que ocorreram em solo brasileiro.</p>
        <p>Dentre as Informações disponíveis estão os dados sobre as aeronaves envolvidas, fatalidades, local, data e horário dos eventos e informações taxonômicas
          típicas das investigações de acidentes (AIG). São resguardadas a privacidade de pessoas físicas/jurídicas envolvidas conforme previsto pela Lei
          de Acesso à Informação.</p>
        <p>Essa base de dados é composta por informações preliminares (provenientes do formulário CENIPA-05 [Ficha de Notificação de Ocorrência Aeronáutica])
          e consolidadas (provenientes dos relatórios de investigações publicados).</p>
      </div>
    </animated-fade-in>
    <animated-fade-in>
      <div id="dataset" >
        <img src="../assets/data_model.png" alt="">
      </div>
    </animated-fade-in>
  </div>
</template>
<script>
  export default {
    name: 'HelloWorld',
    data () {
      return {
        msg: 'Welcome to Your Vue.js App'
      }
    }
  }
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
  h1, h2 {
    font-weight: normal;
  }
  ul {
    list-style-type: none;
    padding: 0;
  }
  li {
    display: inline-block;
    margin: 0 10px;
  }
  a {
    color: #42b983;
  }
  .description {
    text-align: left;
  }
</style>
