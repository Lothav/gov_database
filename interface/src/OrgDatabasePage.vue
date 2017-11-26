<template>
  <div id="org-database-page">
    <div id="title">
      <h1>Opendata AIG Brazil</h1>
      <h2>Ocorrências Aeronáuticas na Aviação Civil Brasileira</h2>
    </div>
    <text-p v-for="desc in descs" :key="desc" :text="desc" />
    <div id="dataset" >
      <img src="./assets/data_model.png" alt="">
    </div>
    <b-form-input @keyup.enter.native="getQuery()" v-model="query" type="text" placeholder="Insira a query SQL"></b-form-input>
    <h2 v-if="rowCount != -1">Total de resultados: {{rowCount}}</h2>
    <div class="table-box">
      <b-table striped hover :items="rows"></b-table>
    </div>
      <pulse-loader class="loading-item" :color="'#333'" :size="'20px'" :loading="loading" ></pulse-loader>
  </div>
</template>
<script>
  import TextP from './components/TextP'
  import PulseLoader from 'vue-spinner/src/PulseLoader.vue'

  export default {
    name: 'org-database-page',
    data () {
      return {
        query: '',
        rows: [],
        loading: false,
        rowCount: -1,
        descs: [
          'A base de dados de ocorrências aronáuticas é gerenciada pelo Centro de Investigação e Prevenção de Acidentes aeonáuticos (CENIPA). Constam nesta base de dados as ocorrências aeronáuticas notificadas ao CENIPA nos últimos 10 anos e que ocorreram em solo brasileiro.',
          'Dentre as Informações disponíveis estão os dados sobre as aeronaves envolvidas, fatalidades, local, data e horário dos eventos e informações taxonômicas típicas das investigações de acidentes (AIG). São resguardadas a privacidade de pessoas físicas/jurídicas envolvidas conforme previsto pela Lei de Acesso à Informação.',
          'Essa base de dados é composta por informações preliminares (provenientes do formulário CENIPA-05 [Ficha de Notificação de Ocorrência Aeronáutica]) e consolidadas (provenientes dos relatórios de investigações publicados).'
        ]
      }
    },
    components: {
      TextP, PulseLoader
    },
    methods: {
      getQuery: function () {
        this.loading = true
        let baseUrl = 'https://luizotavioapi.herokuapp.com/getQuery?q='
        this.$http.get(baseUrl + this.query).then(response => {
          if (response.body && response.body.rows && response.body.rows.length) {
            this.rows = response.body.rows
            this.rowCount = response.body.rowCount
          }
          this.loading = false
        }, response => {
          this.loading = false
        })
      }

    }
  }
</script>
<style>
  #org-database-page {
    font-family: 'Avenir', Helvetica, Arial, sans-serif;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    text-align: center;
    color: #2c3e50;
    padding: 50px;
  }

  .table-box {
    width: 100%;
    max-width: 100%;
  }

  .loading-item {
    top: 45vh;
    left: 45vw;
    position: fixed;

  }
</style>
