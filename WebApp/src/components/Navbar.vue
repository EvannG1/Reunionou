<template>
    <div>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container-fluid">
                <router-link to="/" class="navbar-brand">Reunionou WebApp</router-link>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                    data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                    aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item">
                            <router-link to="/" class="nav-link">Accueil</router-link>
                        </li>
                    </ul>
                    <ul v-if="isLogged" class="navbar-nav">
                        <li class="nav-item">
                            <a @click="logout()" href="#" class="nav-link">Déconnexion</a>
                        </li>
                    </ul>
                    <ul v-else class="navbar-nav">
                        <li class="nav-item">
                            <router-link to="/login" class="nav-link">Connexion</router-link>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
    </div>
</template>

<style lang="scss">
</style>

<script>
export default {
    name: 'Navbar',

    data() {
        return {
            isLogged: false
        }
    },

    methods: {
        checkLogin() {
            if (!this.$store.state.token) {
                this.isLogged = false;
            } else {
                this.isLogged = true;
            }
        },
        logout() {
            this.$store.commit('logout');
            document.location.href = '/login';
        }
    },
    beforeMount() {
        this.checkLogin();
        if (!this.$store.state.token) {
            if (this.$route.name != 'Login') {
                document.location.href = '/login';
            }
        } else {
            if (this.$route.name == 'Login') {
                document.location.href = '/';
            }
        }
    },
}
</script>