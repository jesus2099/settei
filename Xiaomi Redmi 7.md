Xiaomi Redmi 7
==============

Firefox 68.11.0
---------------

Il est important de rester dans cette version pour pouvoir 
continuer d’utiliser les extensions (add-ons), comme Violentmonkey (userscripts), etc.

REACH_DOWNLINK_SMS_LIMITATION
-----------------------------

Erreur à chaque démarrage du Xiaomi Redmi 7 
lors de la tentative de l’_activation de la SIM_ 
pour le _Cloud_ Xiaomi, pour la localisation d’urgence du téléphone 
(ou un autre truc comme ça).

### Solution

> Amigossvenchos
> [#7 2020-06-25 17:10:52](https://c.mi.com/forum.php?mod=redirect&goto=findpost&ptid=2754680&pid=16052709)
> Go to Settings SIM cards & mobile networks > Data roaming 
> and set Overseas data roaming to "Always". 
> Then let it set up everything and turn it off again. 
> This worked for me. 

Effectivement, ça a marché pour moi aussi (ça faisait un an que je cherchais une solution). 

En français :

1. Paramètres
1.2. Cartes SIM & réseaux mobiles
1.3. Itinérance des données : **Toujours**
2. Redémarrer le téléphone et constater l’absence d’erreur
2. On peut ensuite remettre le réglage initial (**Jamais** ou _Seulement pour les exceptions_)
