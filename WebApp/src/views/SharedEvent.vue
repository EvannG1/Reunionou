<template>
    <div>
        <Navbar />
        <div class="container mt-5">
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <div v-if="error" class="alert alert-danger" role="alert">
                        <font-awesome-icon icon="exclamation-circle"></font-awesome-icon> {{ error }}
                    </div>
                    <div class="card">
                        <div class="card-header"><font-awesome-icon icon="plus"></font-awesome-icon> Page de partage d'un évènement</div>
                        <div class="card-body">
                            <form @submit.prevent="shareEvent()">
                                <table class="table mb-4">
                                    <thead class="table">
                                        <tr>
                                            <th>Nom complet</th>
                                            <th>Adresse email</th>
                                            <th></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr :key="index" v-for="(user, index) in users">
                                            <td>{{ user.fullname }}</td>
                                            <td>{{ user.email }}</td>
                                            <td v-if="!tempUser.includes(user.id)"><font-awesome-icon icon="plus" id="faBtn" @click="addUser(user.id)"></font-awesome-icon></td>
                                            <td v-else><font-awesome-icon icon="trash-alt" id="faBtn" @click="deleteUser(user.id)"></font-awesome-icon></td>
                                        </tr>
                                    </tbody>
                                </table>
                                <div class="mb-3">
                                    <label for="url" class="form-label">Lien de partage publique :</label>
                                    <input v-model="url" type="text" class="form-control" id="url" disabled>
                                </div>
                                <div class="d-grid gap-2 mt-3">
                                    <button @click="shareEvent()" class="btn btn-primary" type="button">Partager l'évènement</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<style lang="scss">
#faBtn {
    cursor: pointer;
}
</style>

<script>
import Navbar from '@/components/Navbar.vue';

export default {
  components: {
    Navbar
  },
  data() {
      return {
        error: false,
        success: false,
        tempUser: [],
        users: [],
        url: ''
      }
  },
  methods: {
      shareEvent() {
          this.tempUser.forEach(id => {
              api.post('shared', {
                  event_id: this.$route.params.id,
                  user_id: id,
              });
          });
          alert("L'évènement a bien été partagé !");
          this.$router.push('/');
      },

      addUser(id) {
          this.tempUser.push(id);
      },

      deleteUser(id) {
          for (let i = 0; i < this.tempUser.length; i++) {
              if (this.tempUser[i] === id) {
                  this.tempUser.splice(i, 1);
              }
          }
      },

      getRootURL() {
          return window.location.origin;
      }
  },

  mounted() {
      api.get('event/' + this.$route.params.id).then(response => {
          let data = response.data[0];
          let rootURL = this.getRootURL();
          this.url = rootURL + '/event/' + data.token;
      });

      api.get('users').then(response => {
          response.data.forEach(element => {
            this.users.push(element);
        });
      });
  }
}
</script>