From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:52 +0000
Subject: Information on National Semiconductor chipset PC87366
Message-Id: <1081847794.407baff23d6f7@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <04610DCBF3E19648B8BFEA981A1E464520F8B0@pdbh971a>
In-Reply-To: <04610DCBF3E19648B8BFEA981A1E464520F8B0@pdbh971a>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Je suis d?sol?e de n'avoir pas r?pondu plus t?t ? votre "mesage
> subliminal"; j'ai essay? de voir aupr?s de mes coll?gues de Berlin
> s'il ?tait possible de vous pr?ter une de nos machines, mais comme
> il s'agit d'un prototype, ce n'est pas ?vident.

Je comprends. Notez qu'il n'est pas n?cessaire que ce soit exactement le
m?me syst?me. Tout syst?me pourvu du m?me composant (PC87366) ou a
d?faut de son petit fr?re (PC87365) qui est tr?s similaire ferait
l'affaire.

Et c'?tait juste une suggestion ;) Disons qu'avoir acc?s a un vrai
composant ?a aide toujours ? ?crire le driver et ? le tester. Les
sp?cifications c'est bien (surtout celles de National Semiconductor)
mais ?a ne r?pond pas toujours ? toutes les questions du d?veloppeur.

Notez ?galement qu'un acc?s distant (personnel, bien s?r, via SSH) ? une
machine similaire pourrait suffire. Un acc?s au compte root est
toutefois n?cessaire dans ce cas, je ne sais pas comment ?a peut
s'accorder avec votre politique de s?curit? r?seau.

> Je vous remercie en tout cas de nous signaler cette nouvelle version,
> je vais transmettre l'information ? mes coll?gues et vous tiendrai
> au courant de leurs avanc?es l?-dessus.

OK :) La seule personne ayant test? le driver n'avait manifestement pas
de ventillateurs connect?s sur son PC87366. J'esp?re que vous aurez
plus de chance, mais ? vrai dire, si c'est vous qui concevez la carte,
je suppose que vous savez ce que vous faites et que tout sera
correctement connect? ;)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
