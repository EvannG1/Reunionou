<template>
  <div>
    <Navbar />
    <div class="container mt-5">

      <h1 class="text-center">Mes évènements</h1>
      <div class="text-center mb-3">
        <a href="#">Mes évènements</a> -
        <a href="#">Mes évènements partagés</a>
      </div>

      <div class="row">
        <div class="col-7">
          <div class="card mb-3">
            <img src="http://placehold.it/600x250" class="card-img-top" alt="">
            <div class="card-body">
              <h5 class="card-title">{{ title }}</h5>
              <p class="card-text">{{ description }}</p>
              <p class="card-text"><small class="text-muted"><font-awesome-icon icon="calendar-alt"></font-awesome-icon> Prévu le {{ date }} par {{ author }}</small></p>
            </div>
          </div>
        </div>
        <div class="col-5">
          <div v-for="(event, index) in events" class="list-group">
            <a @click="selectEvent(event.title, event.description, event.date, event.author, index)" href="#" class="list-group-item list-group-item-action" :class="{active:this.index == index}">
              <div class="d-flex w-100 justify-content-between">
                <h5 class="mb-1">{{ event.title }}</h5>
                <small><font-awesome-icon icon="map-marker-alt"></font-awesome-icon> {{ event.location.name }}</small>
              </div>
              <p class="mb-1">{{ event.description }}</p>
              <small><font-awesome-icon icon="calendar-alt"></font-awesome-icon> Prévu le {{ event.date }}</small>
            </a>
          </div>
          <div class="d-grid gap-2">
            <button class="btn btn-primary" type="button">Créer un nouvel évènement</button>
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
      events: [],
      index: false,
      title: false,
      description: false,
      date: false,
      author: false
    }
  },
  methods: {
    selectEvent(title, description, date, author, index) {
      this.index = index;
      this.title = title;
      this.description = description;
      this.date = date;
      this.author = author.fullname;
    }
  },
  mounted() {
    api.get('events').then(response => {
        this.title = response.data.owned[0].title;
        this.description = response.data.owned[0].description;
        this.date = response.data.owned[0].date;
        this.author = response.data.owned[0].author.fullname;
        response.data.owned.forEach(element => {
          this.events.push(element);
        });
    });
  }
}
</script>
