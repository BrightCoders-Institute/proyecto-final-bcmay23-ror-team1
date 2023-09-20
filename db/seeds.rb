# frozen_string_literal: true



users = User.create([
    { 
        name: "Iván", 
        username: "ivan", 
        email: "ivansilva.me@gmail.com", 
        password: "123456",
        confirmed_at: Time.now
    },
    {
        name: "Gabino", 
        username: "gabi", 
        email: "gabinomorales1212@hotmail.com", 
        password: "123456",
        confirmed_at: Time.now
    },
    {
        name: "Juan", 
        username: "juan", 
        email: "juan.michel16@outlook.com", 
        password: "123456" 
    },
    {
        name: "Yoel", 
        username: "yoel", 
        email: "byha010@gmail.com", 
        password: "123456",
        verified: true
    }
])

User.find(1).avatar.attach(io: File.open(Dir.glob("app/assets/images/avatars/*").sample), filename: "default1.png")
User.find(2).avatar.attach(io: File.open(Dir.glob("app/assets/images/avatars/*").sample), filename: "default2.png")
User.find(3).avatar.attach(io: File.open(Dir.glob("app/assets/images/avatars/*").sample), filename: "default4.png")
User.find(4).avatar.attach(io: File.open(Dir.glob("app/assets/images/avatars/*").sample), filename: "default3.png")

posts = Post.create([
    #Posts
    { content: "¡Hola a todos!", user_id: 1 },
    { content: "Compartiendo mi experiencia de hoy", user_id: 2 },
    { content: "¿Qué opinan de este libro?", user_id: 3 },
    { content: "Feliz viernes", user_id: 4 },
    { content: "Este es mi primer post", user_id: 1 },
    { content: "Recién llegado, ¡saludos a la comunidad!", user_id: 2 },
    { content: "Reflexionando sobre la vida", user_id: 3 },
    { content: "Viajando por el mundo", user_id: 4 },
    { content: "¿Alguien quiere tomar un café?", user_id: 1 },
    { content: "Mis planes para el fin de semana", user_id: 2 },
    { content: "Amo la música clásica", user_id: 3 },
    { content: "Compartiendo una receta deliciosa", user_id: 4 },
    { content: "De regreso después de un tiempo", user_id: 1 },
    { content: "Aprendiendo algo nuevo cada día", user_id: 2 },
    { content: "¿Cuál es tu película favorita?", user_id: 3 },
    { content: "Mis pensamientos sobre la tecnología", user_id: 4 },
    { content: "Día soleado en la playa", user_id: 1 },
    { content: "Trabajando en un nuevo proyecto", user_id: 2 },
    { content: "Mis metas para este año", user_id: 3 },
    { content: "Haciendo ejercicio en el parque", user_id: 4 },
    { content: "Celebrando un logro importante", user_id: 1 },
    { content: "Explorando nuevas oportunidades", user_id: 2 },
    { content: "Mis pensamientos sobre el arte", user_id: 3 },
    { content: "Relajándome en casa", user_id: 4 },
    { content: "¡Buenos días a todos!", user_id: 1 },
    { content: "Viajando por Europa", user_id: 2 },
    { content: "Mis libros favoritos", user_id: 3 },
    { content: "Dando un paseo por el bosque", user_id: 4 },
    { content: "¿Qué opinan sobre la política actual?", user_id: 1 },
    { content: "Disfrutando de la comida local", user_id: 2 },

    # Comments
    { content: "¡Gran primer post! Bienvenido a la comunidad.", user_id: 2, parent_id: 1 },
    { content: "Estoy emocionado por lo que compartiste. ¿Qué más tienes planeado?", user_id: 3, parent_id: 2 },
    { content: "Ese libro es increíble. Lo leí el año pasado.", user_id: 4, parent_id: 3 },
    { content: "¡Feliz viernes para ti también! ¿Alguna diversión planeada para el fin de semana?", user_id: 1, parent_id: 4 },
    { content: "¡Me encanta tu primer post! Espero ver más de tus publicaciones.", user_id: 2, parent_id: 5 },
    { content: "¡Saludos! ¿Cómo te enteraste de esta comunidad?", user_id: 3, parent_id: 6 },
    { content: "Reflexionar sobre la vida es importante. ¿Algún consejo que quieras compartir?", user_id: 4, parent_id: 7 },
    { content: "¿Qué lugares has visitado recientemente en tus viajes?", user_id: 1, parent_id: 8 },
    { content: "Me encantaría tomar un café contigo. ¿Dónde te encuentras?", user_id: 2, parent_id: 9 },
    { content: "¡Espero que tengas un fin de semana emocionante! ¿Qué tienes planeado?", user_id: 3, parent_id: 10 },
    { content: "¡La música clásica es maravillosa! ¿Tienes algún compositor favorito?", user_id: 4, parent_id: 11 },
    { content: "¿Puedes compartir la receta? ¡Me encantaría probarla!", user_id: 1, parent_id: 12 },
    { content: "¡Bienvenido de vuelta! ¿Qué te hizo regresar?", user_id: 2, parent_id: 13 },
    { content: "Aprender cosas nuevas es genial. ¿Algún tema en particular te interesa?", user_id: 3, parent_id: 14 },
    { content: "¡Mi película favorita es 'El Padrino'! ¿Cuál es la tuya?", user_id: 4, parent_id: 15 },
    { content: "Estoy interesado en escuchar tus pensamientos sobre la tecnología. ¿Qué tienes en mente?", user_id: 1, parent_id: 16 },
    { content: "¡Disfruta del día soleado en la playa! ¿En qué playa te encuentras?", user_id: 2, parent_id: 17 },
    { content: "¿Puedes hablar más sobre tu nuevo proyecto? Suena emocionante.", user_id: 3, parent_id: 18 },
    { content: "¿Cuáles son algunas de tus metas para este año? Me encantaría saber más.", user_id: 4, parent_id: 19 },
    { content: "Hacer ejercicio en el parque es una excelente manera de mantenerse activo. ¿Qué tipo de ejercicio haces?", user_id: 1, parent_id: 20 },
    { content: "¡Felicidades por el logro! ¿Puedes compartir más detalles?", user_id: 2, parent_id: 21 },
    { content: "Explorar nuevas oportunidades es emocionante. ¿En qué estás interesado?", user_id: 3, parent_id: 22 },
    { content: "El arte es inspirador. ¿Tienes algún artista favorito?", user_id: 4, parent_id: 23 },
    { content: "Relajarse en casa es genial. ¿Algún plan relajante para hoy?", user_id: 1, parent_id: 24 },
    { content: "¡Buenos días! ¿Qué te trae por aquí hoy?", user_id: 2, parent_id: 25 },
    { content: "¿Cuál es tu destino favorito en Europa hasta ahora?", user_id: 3, parent_id: 26 },
    { content: "Me encanta leer también. ¿Tienes alguna recomendación de libros?", user_id: 4, parent_id: 27 },
    { content: "Los paseos por el bosque son tan relajantes. ¿Dónde te gusta caminar?", user_id: 1, parent_id: 28 },
    { content: "La política es un tema interesante. ¿Qué te gustaría discutir sobre ella?", user_id: 2, parent_id: 29 },
    { content: "¡La comida local es la mejor! ¿Dónde disfrutaste tu última comida local?", user_id: 3, parent_id: 30 },
])

follow = Follow.create([
    { follower_id: 1, following_id: 2 },
    { follower_id: 1, following_id: 3 },
    { follower_id: 1, following_id: 4 },
    { follower_id: 2, following_id: 3 },
    { follower_id: 2, following_id: 4 },
    { follower_id: 3, following_id: 1 },
    { follower_id: 3, following_id: 2 },
    { follower_id: 3, following_id: 4 },
])
