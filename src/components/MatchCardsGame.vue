<template>
  <div class="match-container">
    <h2>Match the descriptions to the images</h2>

    <!-- Card‑type selector (does NOT auto‑refresh; hit “Next” to apply) -->
    <div class="type-selector" style="margin-bottom:12px;">
      <label for="cardTypeSelect">Card type:&nbsp;</label>
      <select id="cardTypeSelect" v-model="selectedType">
        <option value="">All</option>
        <option v-for="t in availableTypes" :key="t" :value="t">{{ t }}</option>
      </select>
    </div>

    <div class="match-columns">
      <div class="cards">
        <div
          v-for="card in currentImageCards"
          :key="card.id"
          class="image-card"
          :class="{ matched: matchedIds.includes(card.id) }"
          @dragover.prevent
          @drop="handleDrop(card)"
        >
          <img :src="card.image" alt="Card Image" />
        </div>
      </div>

      <div class="descriptions">
        <div
          v-for="card in currentDescriptionCards"
          :key="card.id"
          class="description-card"
          draggable="true"
          @dragstart="handleDragStart(card)"
          :class="{ matched: matchedIds.includes(card.id) }"
        >
          <div class="desc-card-id">#{{ card.id }}</div>
          <div class="desc-card-text">{{ card.description }}</div>
        </div>
      </div>
    </div>

    <div class="button-bar">
      <button @click="$emit('back')">Back to Menu</button>
      <button @click="nextBatch">Next</button>
    </div>
  </div>
</template>

<script>
export default {
  name: "MatchCardsGame",
  props: ["cards"],
  data() {
    return {
      selectedType: "",            // value bound to <select>
      availableTypes: [],           // distinct "type" values
      allCards: [],                 // shuffled pool respecting selectedType
      currentIndex: 0,
      draggedCard: null,
      matchedIds: []
    };
  },
  computed: {
    currentBatch() {
      return this.allCards.slice(this.currentIndex, this.currentIndex + 4);
    },
    currentImageCards() {
      return this.currentBatch;
    },
    currentDescriptionCards() {
      return this.shuffle([...this.currentBatch]);
    }
  },
  methods: {
    // ───────────── batching / filtering ─────────────
    rebuildPool() {
      const pool = this.selectedType
        ? this.cards.filter(c => c.type === this.selectedType)
        : this.cards;
      this.allCards = this.shuffle([...pool]);
      this.currentIndex = 0;
    },
    nextBatch() {
      // apply filter if user changed type since last time
      if (this.needsRebuild) {
        this.rebuildPool();
        this.needsRebuild = false;
      }

      this.matchedIds = [];
      if (this.currentIndex + 4 >= this.allCards.length) {
        this.currentIndex = 0;
      } else {
        this.currentIndex += 4;
      }
    },

    // ───────────── drag‑and‑drop ─────────────
    handleDragStart(card) {
      this.draggedCard = card;
    },
    handleDrop(targetCard) {
      if (this.draggedCard && this.draggedCard.id === targetCard.id) {
        this.matchedIds.push(targetCard.id);
      }
      this.draggedCard = null;
    },

    // ───────────── utils ─────────────
    shuffle(array) {
      const a = [...array];
      for (let i = a.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        [a[i], a[j]] = [a[j], a[i]];
      }
      return a;
    }
  },
  watch: {
    // mark that we need a fresh pool when user picks a new type
    selectedType() {
      this.needsRebuild = true;
    }
  },
  created() {
    // distinct card types for the selector
    this.availableTypes = [...new Set(this.cards.map(c => c.type))];
    this.rebuildPool();
    this.needsRebuild = false;
  }
};
</script>

<style scoped>
/* identical layout & styles from the original component */
.match-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  margin-top: 20px;
}

.button-bar {
  display: flex;
  gap: 10px;
  margin-bottom: 15px;
}

.match-columns {
  display: flex;
  justify-content: center;
  align-items: flex-start;
  gap: 20px;
  flex-wrap: wrap;
}

.cards,
.descriptions {
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.image-card,
.description-card {
  border: 2px solid #333;
  border-radius: 6px;
  padding: 10px;
  width: 140px;
  height: 140px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  transition: background-color 0.3s ease, border-color 0.3s ease;
}

@media (max-width: 600px) {
  .image-card,
  .description-card {
    width: 100px;
    height: 100px;
  }
  .desc-card-text,
  .desc-card-id,
  .image-id {
    font-size: 12px;
  }
}

.image-card.matched,
.description-card.matched {
  border-color: green;
  background-color: #c8e6c9;
}

.image-card img {
  max-width: 100%;
  max-height: 100%;
}

.description-card {
  cursor: grab;
  text-align: center;
}

.desc-card-id {
  font-weight: bold;
  margin-bottom: 5px;
}

.desc-card-text {
  font-size: 16px;
}

button {
  margin: 5px;
}
</style>
