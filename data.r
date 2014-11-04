# load traffic data from image.
# else do data pre-processing and save image.
load.data <- function() {
  # load traffic data from prevously prepared image.
  if(file.exists("data/bin/traffic.bin"))
    load(file=paste0("data/bin/traffic.bin"), verbose=T)
  else {
    # load the traffic.data from csv
    print("loading data from csv. this will take some time...")
    traffic.data <- read.csv("data/csv/traffic.csv", header=F, sep=",")
    # set the columns
    colnames(traffic.data) <- c("timestamp", "route", "from", "lng1", "lat1", 
        "lng2", "lat2", "to", "direction", "length", "speed")
    # re-order the columns
    traffic.data <- traffic.data[, c("timestamp", "route", "from", "to", 
        "direction", "lat1", "lng1", "lat2", "lng2", "length", "speed")]
    # set the timestamps
    # data timestamps are actually greek local time (eastern european time)
    print("setting timestamps...")
    traffic.data$timestamp <- as.POSIXct(traffic.data$timestamp, 
        origin="1970-01-01", tz="UTC")
    traffic.data$timestamp <- trunc(traffic.data$timestamp, "mins")
    # translate into greeklish
    print("translating...")
    levels(traffic.data$route) <- sapply(levels(traffic.data$route), function(v) {
      switch(v, 
        "Λ.ΑΘΗΝΩΝ"="Athenon", 
        "Λ.ΑΛΕΞΑΝΔΡΑΣ"="Alexandras",
        "Λ.ΒΟΥΛΙΑΓΜΕΝΗΣ"="Voulagmenis",
        "Λ.ΚΗΦΙΣΙΑΣ"="Kifisias",
        "Λ.ΚΗΦΙΣΟΥ"="Kifisou",
        "Λ.ΠΟΣΕΙΔΩΝΟΣ"="Poseidonos",
        "Λ.ΣΥΓΓΡΟΥ"="Syggrou",
        "ΜΕΣΟΓΕΙΩΝ"="Mesogeion",
        "ΠΕΙΡΑΙΩΣ"="Peiraios",
        "ΣΚΥΛΙΤΣΗ ΟΜΗΡΙΔΟΥ"="Skilitsi Omiridou",
        stop()
      )
    })
    levels(traffic.data$from) <- sapply(levels(traffic.data$from), function(v) {
      switch(v,
        "ΘΗΒΩΝ"="Thevon",
        "ΓΕΩΠΟΝΙΚΗ ΣΧΟΛΗ"="Geoponikh School",
        "ΠΑΤΗΣΙΩΝ"="Patision",
        "ΕΛΛΗΝΙΚΟ"="Elliniko",
        "ΜΕΓΑΡΟ ΟΤΕ"="Big OTE",
        "ΚΑΤΕΧΑΚΗ"="Katehaki",
        "ΜΕΤΑΜΟΡΦΩΣΗ"="Metamorphosi",
        "RENAULT"="Renault",
        "ΤΡΕΙΣ ΓΕΦΥΡΕΣ"="Treis Gefures",
        "ΑΛΛΟΥ ΦΑΝ ΠΑΡΚ"="Allu Fun Park",
        "ΚΕΝΤΡ.ΛΑΧΑΝΑΓΟΡΑ"="Laxanagora Centre",
        "ΙΕΡΑ ΟΔΟ"="Iera Odo",
        "ΠΡΙΝ ΤΟΝ ΚΟΜΒΟ ΣΕΦ"="Before Sef Junction",
        "Λ.ΑΛΙΜΟΥ"="Alimou",
        "ΥΨΟΣ ΠΑΝΤΕΙΟΥ"="Ypsos Panteiou",
        "ΥΨΟΣ ΔΑΒΑΚΗ"="Ypsos Davaki",
        "ΣΤΑΥΡΟ ΑΓ.ΠΑΡΑΣΚΕΥΗΣ"="Agia Paraskevi Stadium",
        "ΧΑΜΟΣΤΕΡΝΑΣ"="Xamosternas",
        "ΓΗΠΕΔΟ ΚΑΡΑΪΣΚΑΚΗ"="Gepedo Karaiskaki",
        "ΒΟΥΛΑ"="Boula",
        stop()
      )
    })
    levels(traffic.data$to) <- sapply(levels(traffic.data$to), function(v) {
      switch(v,
        "ΑΓ. ΔΗΜΗΤΡΙΟ (ΣΤΑΣΗ ΜΕΤΡΟ)"="Agios Demitrios Metro Station",
        "ΑΧΑΡΝΩΝ"="Axarnon",
        "ΔΑΦΝΙ (μέσω Λ.ΑΘΗΝΩΝ)"="Dafni inside Athenon",
        "ΚΑΤΕΧΑΚΗ (μέσω Λ.ΑΛΕΞΑΝΔΡΑΣ-ΚΗΦΙΣΙΑΣ)"="Katehaki inside Alexandras",
        "ΚΟΜΒΟ ΣΕΦ (μέσω Λ.ΚΗΦΙΣΟΥ)"="Sef junction inside Kifisou",
        "Λ.ΑΛΙΜΟΥ (μέσω Λ.ΠΟΣΕΙΔΩΝΟΣ)"="Alimou inside Poseidonos",
        "ΟΜΟΝΟΙΑ (μέσω Λ.ΑΘΗΝΩΝ)"="Omonia inside Athenon",
        "ΟΜΟΝΟΙΑ (μέσω Π.ΡΑΛΛΗ)"="Omonia inside Rally Square",
        "ΠΛ.ΙΠΠΟΔΑΜΕΙΑΣ (ΠΕΙΡΑΙΑΣ) (μέσω ΜΙΚΡΑΣ ΑΣΙΑΣ)"="Ippodameias Square Peiraias",
        "ΣΥΝΤΑΓΜΑ (μέσω ΑΜΑΛΙΑΣ)"="Syntagma inside Amalias",
        "ΧΙΛΤΟΝ"="Hilton",
        "ΑΤΤΙΚΗ ΟΔΟ"="Attiki Odos",
        "ΓΛΥΦΑΔΑ (μέσω Λ.ΠΟΣΕΙΔΩΝΟΣ)"="Glyfada inside Poseidonos",
        "ΙΕΡΑ ΟΔΟ (μέσω Λ.ΚΗΦΙΣΟΥ)"="Iera inside Kifisou",
        "ΚΑΤΕΧΑΚΗ (μέσω ΜΕΣΟΓΕΙΩΝ)"="Katehaki inside Mesogeion",
        "Λ.ΑΘΗΝΩΝ"="Athenon",
        "ΛΕΝΟΡΜΑΝ"="Lenorman",
        "ΟΜΟΝΟΙΑ (μέσω Λ.ΠΟΣΕΙΔΩΝΟΣ-Λ.ΚΗΦΙΣΟΥ-Π.ΡΑΛΛΗ)"="Omonia inside Poseidonos-kifisou-rally",
        "ΠΛ.ΙΠΠΟΔΑΜΕΙΑΣ (ΠΕΙΡΑΙΑΣ) (μέσω Λ.ΠΟΣΕΙΔΩΝΟΣ)"="Ippodameias Square Peirais inside Poseidonos",
        "ΣΤΑΥΡΟ ΑΓ.ΠΑΡΑΣΚΕΥΗΣ"="Stavro Agia Paraskevis",
        "ΣΥΝΤΑΓΜΑ (μέσω ΒΑΣ.ΣΟΦΙΑΣ)"="Syntagma inside Vasilissis Sofias",
        "ΧΙΛΤΟΝ (μέσω ΒΑΣ.ΣΟΦΙΑΣ)"="Hilton inside Vasilissis Sofias",
        "ΑΤΤΙΚΗ ΟΔΟ (μέσω Λ.ΚΗΦΙΣΟΥ)"="Attiki Odos inside Kifisou",
        "ΔΑΦΝΙ"="Dafni",
        "ΚΑΤΕΧΑΚΗ"="Katehaki",
        "ΚΟΜΒΟ ΣΕΦ"="Sef Junction",
        "Λ.ΑΛΙΜΟΥ"="Alimou",
        "ΟΜΟΝΟΙΑ"="Omonia",
        "ΟΜΟΝΟΙΑ (μέσω Λ.ΠΟΣΕΙΔΩΝΟΣ-Λ.ΣΥΓΓΡΟΥ)"="Omonia inside Poseidonos-Syggrou",
        "ΠΛ.ΙΠΠΟΔΑΜΕΙΑΣ (ΠΕΙΡΑΙΑΣ) (μέσω Λ.ΠΟΣΕΙΔΩΝΟΣ-ΜΙΚΡΑΣ ΑΣΙΑΣ)"="Ippodameias Square Peiraias inside Poseidonos-Asia Minor",
        "ΣΥΝΤΑΓΜΑ"="Syntagma",
        "ΣΥΝΤΑΓΜΑ (μέσω Λ.ΣΥΓΓΡΟΥ)"="Syntagma inside Syggrou",
        stop()
      )
    })
    levels(traffic.data$direction) <- sapply(levels(traffic.data$direction), function(v) {
      switch(v,
        "ΒΟΡΕΙΑ"="North",
        "ΓΛΥΦΑΔΑ"="Glyfada",
        "ΔΑΦΝΙ"="Dafni",
        "ΚΑΤΕΧΑΚΗ"="Katehaki",
        "ΚΕΝΤΡΟ"="Centre",
        "ΚΗΦΙΣΙΑ"="Kifisia",
        "ΠΕΙΡΑΙΑ"="Peiraia",
        "ΣΤΑΥΡΟ"="Stavro",
        stop()
      )
    })
    # save image
    save(file="data/bin/traffic.bin", list="traffic.data")
  }
  traffic.data
}

