class Dashing.display extends Dashing.Widget

# ajouter un evenement qui va stocker l ancienne donnee et afficher la nouvelle. Pour ainsi déplacer les données

# OnData?

onData: (data)->

    if (data.lenght  >= 140)
        console.log('Votre message est trop long')

