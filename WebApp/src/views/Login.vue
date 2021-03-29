<template>
    <div>
        <Navbar />
        <div class="container mt-5">
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <div class="card">
                        <div class="card-header">Page de connexion</div>
                        <div class="card-body">
                            <form @submit.prevent="login()">
                                <div class="form-group row">
                                    <label for="email" class="col-md-4 col-form-label text-md-right">Adresse mail</label>
                                    <div class="col-md-6">
                                        <input v-model="email" type="email" id="email" class="form-control" required>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="password" class="col-md-4 col-form-label text-md-right">Mot de passe</label>
                                    <div class="col-md-6">
                                        <input v-model="password" type="password" id="password" class="form-control" required>
                                    </div>
                                </div>

                                <div class="col-md-6 offset-md-4">
                                    <button class="btn btn-primary">Connexion</button>
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
</style>

<script>
import Navbar from '@/components/Navbar.vue';

export default {
  components: {
    Navbar
  },
  data() {
      return {
          email: 'john@local.dev',
          password: 'admin'
      }
  },
  methods: {
      login() {
          api.post('signin', {
             email: this.email,
             password: this.password 
          }).then(response => {
              this.$store.commit('setFullname', response.data.fullname);
              this.$store.commit('setEmail', response.data.email);
              this.$store.commit('setToken', response.data.token);
              this.$router.push('/');
          })
      }
  }
}
</script>