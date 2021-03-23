comments table :
comprend deux clés étrangères users_id et events_id 
qui font référence aux clés primaires des tables users et events
permettent de savoir pour tel comment, a quel user et à quel event il appartient

events table:
comprend une clé étrangère location_id
qui fait référence à la clé primaire de la table location 
permet de connaitre les détails de l'adresse d'un event  

guests table:
comprend trois clés étrangères status_id, u_id et e_id
dont e_id et u_id en clé primaire puisque pour un event on ne peut être invité qu'une seule fois
qui font référence aux clés primaires des tables status, users et events
permettent de savoir pour tel statut, à quel user et à quel event il appartient

location table:
permet d'éviter les répétitions d'informations
(ex: deux events au même lieu malgré une date différente)

status table:
permet d'éviter les répétitions d'informations
ne donnera le choix qu'à deux statuts, disponnible ou non
a pas répondu étant le statut par défaut
