<template>
  <div id="app">
    <text-p v-for="desc in descs" :key="desc" :text="desc"/>
  </div>
</template>
<script>
  import TextP from './components/TextP'
  export default {
    name: 'app',
    data () {
      return {
        descs: [
          'A base de dados de ocorrências aronáuticas é gerenciada pelo Centro de Investigação e Prevenção de Acidentes aeonáuticos (CENIPA). Constam nesta base de dados as ocorrências aeronáuticas notificadas ao CENIPA nos últimos 10 anos e que ocorreram em solo brasileiro.',
          'Dentre as Informações disponíveis estão os dados sobre as aeronaves envolvidas, fatalidades, local, data e horário dos eventos e informações taxonômicas típicas das investigações de acidentes (AIG). São resguardadas a privacidade de pessoas físicas/jurídicas envolvidas conforme previsto pela Lei de Acesso à Informação.',
          'Essa base de dados é composta por informações preliminares (provenientes do formulário CENIPA-05 [Ficha de Notificação de Ocorrência Aeronáutica]) e consolidadas (provenientes dos relatórios de investigações publicados).'
        ]
      }
    },
    components: {
      TextP
    }
  }
</script>
<style>
  #app {
    font-family: 'Avenir', Helvetica, Arial, sans-serif;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    text-align: center;
    color: #2c3e50;
    margin-top: 60px;
  }
</style>
