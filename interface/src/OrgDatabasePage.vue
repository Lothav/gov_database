<template>
  <div>
    <a href="https://github.com/Luiz0tavio/gov_database.git"><img style="position: absolute; top: 0; right: 0; border: 0;" src="https://camo.githubusercontent.com/38ef81f8aca64bb9a64448d0d70f1308ef5341ab/68747470733a2f2f73332e616d617a6f6e6177732e636f6d2f6769746875622f726962626f6e732f666f726b6d655f72696768745f6461726b626c75655f3132313632312e706e67" alt="Fork me on GitHub" data-canonical-src="https://s3.amazonaws.com/github/ribbons/forkme_right_darkblue_121621.png"></a>
    <div id="org-database-page">
      <div id="title">
        <h1>Opendata AIG Brazil</h1>
        <h2>Ocorrências Aeronáuticas na Aviação Civil Brasileira</h2>
      </div>
      <text-p v-for="desc in descs" :key="desc" :text="desc" />
      <h4>Consulta ao banco</h4>
      <text-p :text="'Modelo relacional:'" />
      <div id="dataset" >
        <img src="./assets/data_model.png" alt="">
      </div>
      <p>
        Utilizando o modelo relacional descrito acima, e utilizando o campo abaixo, é possível fazer consultas ao banco de dados.
      </p>
      Algumas considerações:
      <ul>
        <li>
          O SGBD em questão é o Postgres, portanto, algumas consultas MySQL podem não funcionar.
        </li>
        <li>
          O banco está configurado para <i>read-only</i>.
        </li>
        <li>
          O tempo de resposta é contabilizado apenas para a consulta, ou seja, o tempo entre as requisições não é contabilizado.
        </li>
        <li>
          Foi utilizado um <i>Cloud Service</i> gratuito e limitado, portanto, instabilidades são inevitáveis.
        </li>
      </ul>
      <p>Insira no campo abaixo sua pesquisa e pressione <b>Enter/Return</b>:</p>
      <div class="query-input">
        <b-form-input @keyup.enter.native="getQuery()" v-model="query" type="text" placeholder="Insira a query SQL"></b-form-input>
      </div>
      <b-container class="bv-example-row">
        <b-row>
          <b-col><div class="total-result" v-if="rowCount != -1">Total de resultados: <b>{{rowCount}}</b></div></b-col>
          <b-col><div class="total-result" v-if="timeSpent != -1">Tempo gasto: <b>{{timeSpent}}ms</b></div></b-col>
        </b-row>
      </b-container>
    </div>
    <div class="table-box" v-if="rows.length">
      <template>
        <animated-fade-out-down>
          <b-table striped hover :items="rows"></b-table>
        </animated-fade-out-down>
      </template>
    </div>
    <pulse-loader class="loading-item" :color="'#333'" :size="'20px'" :loading="loading" ></pulse-loader>
  </div>
</template>
<script>
  import TextP from './components/TextP'
  import PulseLoader from 'vue-spinner/src/PulseLoader.vue'
  import swal from 'sweetalert2'

  export default {
    name: 'org-database-page',
    data () {
      return {
        query: '',
        rows: [],
        loading: false,
        rowCount: -1,
        timeSpent: -1,
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
        if (this.query === '') {
          swal({
            title: 'Atenção',
            html: 'Query não pode ser vazia',
            type: 'info',
            confirmButtonText: 'Beles'
          })
          return
        }

        this.rows = []
        this.rowCount = -1
        this.timeSpent = -1
        this.loading = true

        let baseUrl = 'https://luizotavioapi.herokuapp.com/getQuery?q=' + this.query
        this.query = ''
        this.$http.get(baseUrl).then(response => {
          if (response.body && response.body.rows && response.body.rows.length) {
            this.rows = response.body.rows
            this.timeSpent = response.body.time
            let time = 50
            for (let heig = 500; heig < document.body.scrollHeight; heig += 10) {
              time += 15
              setTimeout(function () {
                window.scrollTo(0, heig)
              }, time)
            }
            this.rowCount = response.body.rowCount
          } else {
            let err = 'Sua query não é válida!'
            if (response.body.routine === 'PreventCommandIfReadOnly') {
              err = 'Você não tem permissão para isso pequeno gafanhoto'
            }
            console.log(response)
            err += ('<br><br> Erro: <b>' + response.body.routine + '</b>')
            swal({
              title: 'Erro',
              html: err,
              type: 'error',
              confirmButtonText: 'Ok :/'
            })
          }
          this.loading = false
        }, () => {
          swal({
            title: 'Erro',
            text: 'Servidor faleceu',
            type: 'error',
            confirmButtonText: 'Ok :/'
          })
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
    height: 95vh;
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
