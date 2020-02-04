<template>
    <v-app>
      <v-row justify="center">
        <v-dialog v-model="dialog" persistent max-width="600px">
          <v-card>
            <v-card-title>
              <span class="headline">新しい予定</span>
            </v-card-title>
            <v-card-text>
              <v-container>
                <v-row>
                  <v-col cols="12">
                    <v-text-field v-model="event.title" label="件名*" type="text" :rules="[required]"></v-text-field>
                  </v-col>
                  <v-col cols="12" sm="6" md="4">
                    <v-text-field v-model="event.start" label="開始日時*" type="text" hint="2020-01-01 00:00:00" :rules="[required]"></v-text-field>
                  </v-col>
                  <v-col cols="12" sm="6" md="4">
                    <v-text-field v-model="event.end" label="終了日時" type="text" hint="2020-01-01 00:00:00"></v-text-field>
                  </v-col>
              <v-checkbox v-model="event.allday" type="checkbox" class="mx-2" label="終日"></v-checkbox>
                </v-row>
              </v-container>
              <small>*必須項目</small>
            </v-card-text>
            <v-card-actions>
              <v-spacer></v-spacer>
              <v-btn class="vuetify-btn" @click.stop="dialog = false">閉じる</v-btn>
              <v-btn class="vuetify-btn" :disabled="( !event.title || !event.start )" @click.stop="createEvent">保存する</v-btn>
            </v-card-actions>
          </v-card>
        </v-dialog>
      </v-row>
  </v-app>
</template>

<script>
  import axios from 'axios'
  export default {
    props: { 
      dialog: Boolean,
      eventStart: String
    },
    data () {
      return {
        dialog: this.dialog,
        event: {
          title: '',
          start: this.eventStart,
          end: '',
          allday: false
        },
        required: value => !!value || "必ず入力してください" 
      }
    },
    methods: {
      createEvent () {
        this.dialog = false;
        axios.post('/api/events', { event: this.event }).then((res) => {
          this.$emit('reloadEvent');
          this.dialog = false
          alert('予定が登録されました');
        }, (error) => {
          console.log(error);
        });
      }
    }
  }
</script>

<style>
  .vuetify-btn {
    color: white!important
  }
</style>