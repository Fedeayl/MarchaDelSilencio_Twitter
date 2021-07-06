####### Marcha 2021 - Descarga de tweets ######


#Carga de credenciales - API Twitter rtweet
twitter_token <- create_token(
        app = "ApPCP",
        consumer_key = "OXjLHAthzdmlFclHWjYQQ7tjX",
        consumer_secret = "Hz7q0qXjvx6VZH5B3syW6BiVvJfQNT8XOp82UJPObp7fqLtUEz",
        access_token = "220201468-Qw7Maqew9BcTeLRqThDu138IGNsfIwhcRLDysmrz", 
        access_secret = "ciBKDI0HKST0WMIkHXYKQMdTO8FsxUr9Qhfn2246csMFx")

twitteR::setup_twitter_oauth(consumer_key = "OXjLHAthzdmlFclHWjYQQ7tjX",
                             consumer_secret = "Hz7q0qXjvx6VZH5B3syW6BiVvJfQNT8XOp82UJPObp7fqLtUEz",
                             access_token = "220201468-Qw7Maqew9BcTeLRqThDu138IGNsfIwhcRLDysmrz", 
                             access_secret = "ciBKDI0HKST0WMIkHXYKQMdTO8FsxUr9Qhfn2246csMFx" )

#Definición de términos de búsqueda
T_Oficiales <- "#MarchadelSilencio2021 OR #MarchadelSilencioPresente 
OR #MayoMesdelaMemoria OR #MarchadelSilencio"

T_Alternativos <- "Nunca+mas OR verdad+justicia OR olvido+perdon OR Donde+estan 
OR #Dondeestan OR #nuncamas OR terrorismo+de+estado OR Marcha OR Presente OR 
Son+Presente OR desaparecidos OR desaparecido OR desaparecida OR dictadura OR 
militares OR milicos"

T_Tupamaros <- "tupamaros OR tupas OR tupamaro OR tupa"

#Descarga de tweets con rtweet
Oficiales <- rtweet::search_tweets(T_Oficiales, n = 500000, 
                                   retryonratelimit = TRUE, type = "recent",
                                   include_rts = TRUE, lang = "es")


Alternativos <- rtweet::search_tweets(T_Alternativos, n = 500000, 
                                   retryonratelimit = TRUE, type = "recent",
                                   include_rts = TRUE, lang = "es", geocode = "-34.82,-56.20,50mi") # "-34.82,-56.20" = Montevideo


Tupamaros <- rtweet::search_tweets(T_Tupamaros, n = 500000, 
                                   retryonratelimit = TRUE, type = "recent",
                                   include_rts = TRUE, lang = "es")

#Descarga de tweets con twitteR
Oficiales2 <- twitteR::searchTwitteR(T_Oficiales, n=500000, retryOnRateLimit = 120)
Alternativos2 <- twitteR::searchTwitteR(T_Alternativos, n=500000, retryOnRateLimit = 120, geocode = "-34.82,-56.20,50mi")
Tupamaros2 <- twitteR::searchTwitteR(T_Tupamaros, n=500000, retryOnRateLimit = 120)


# Guardado de las bases rtweet
saveRDS(Oficiales, file=here::here("Data", "2021","Oficiales_rtweet.rds"))
saveRDS(Alternativos, file=here::here("Data", "2021","Alternativos_rtweet.rds"))
saveRDS(Tupamaros, file=here::here("Data", "2021","Tupamaros_rtweet.rds"))
#También en .csv por las dudas
save_as_csv(Oficiales,file_name=here::here("Data", "2021","Oficiales_rtweet.csv"))
save_as_csv(Alternativos,file_name=here::here("Data", "2021","Alternativos_rtweet.csv"))
save_as_csv(Tupamaros,file_name=here::here("Data", "2021","Tupamaros_rtweet.csv"))


# Convertir para poder exportar las bases de twitteR
A <- twitteR::twListToDF(Oficiales2)
B <- twitteR::twListToDF(Alternativos2)
C <- twitteR::twListToDF(Tupamaros2)

# Guardado de las bases de twitteR
write.csv(A, file=here::here("Data","2021","Oficiales_tweetR.csv"))
write.csv(B, file=here::here("Data","2021","Alternativos_tweetR.csv"))
write.csv(C, file=here::here("Data","2021","Tupamaros_tweetR.csv"))
