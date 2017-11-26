<template>
  <div>
    <div id="org-database-page">
      <div id="title">
        <h1>Opendata AIG Brazil</h1>
        <h2>Ocorrências Aeronáuticas na Aviação Civil Brasileira</h2>
      </div>
      <text-p v-for="desc in descs" :key="desc" :text="desc" />
      <h4>Consulta ao banco</h4>
      <text-p :text="'Utilizando o modelo relacional descrito abaixo, é possível fazer consultas no banco:'" />
      <div id="dataset" >
        <img src="./assets/data_model.png" alt="">
      </div>
      <p>Insira no campo abaixo sua pesquisa e pressione <b>Enter</b>:</p>
      <div class="query-input">
        <b-form-input @keyup.enter.native="getQuery()" v-model="query" type="text" placeholder="Insira a query SQL"></b-form-input>
      </div>
      <div class="total-result" v-if="rowCount != -1">Total de resultados: <b>{{rowCount}}</b></div>
    </div>
    <div class="table-box" v-if="rows.length">
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
        this.rows = []
        this.loading = true
        let baseUrl = 'https://luizotavioapi.herokuapp.com/getQuery?q=' + this.query
        this.query = ''
        this.$http.get(baseUrl).then(response => {
          if (response.body && response.body.rows && response.body.rows.length) {
            this.rows = response.body.rows
            let time = 50
            for (let heig = 500; heig < document.body.scrollHeight; heig += 10) {
              time += 15
              setTimeout(function () {
                window.scrollTo(0, heig)
              }, time)
            }
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
    color: #2c3e50;
    padding: 50px 30px 0 30px;
  }

  .query-input {
    margin-bottom: 15px;
  }

  #title {
    text-align: center;
    margin-bottom: 40px;
  }

  .table-box {
    width: 100%;
    max-width: 100%;
    overflow: auto;
    font-size: 12px;
    height: 100vh;
  }

  #dataset img{
    width: 100%;
  }

  .loading-item {
    top: 45vh;
    left: calc(50vw - 36px);
    position: fixed;
  }

  .total-result {
    margin: 15px 0;
  }
</style>
