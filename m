From: Elodie.Bervas@wincor-nixdorf.com (Bervas, Elodie)
Date: Thu, 19 May 2005 06:24:52 +0000
Subject: Information on National Semiconductor chipset PC87366
Message-Id: <04610DCBF3E19648B8BFEA981A1E464520F90A@pdbh971a>
List-Id: <lm-sensors.vger.kernel.org>
References: <04610DCBF3E19648B8BFEA981A1E464520F8B0@pdbh971a>
In-Reply-To: <04610DCBF3E19648B8BFEA981A1E464520F8B0@pdbh971a>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Bonjour,

Pour pr?ciser un peu les choses, les machines dont nous parlons sont des
caisses d'enregistrement pour la distribution, pour lesquelles est
d?velopp?e une nouvelle carte m?re contenant le fameux composant... et non,
ce n'est pas moi qui con?ois la carte! Les d?veloppements (? la fois
mat?riels et logiciels) sont faits par des ?quipes allemandes au si?ge
(Paderborn) ou ? Berlin... Et ces prototypes ne sont g?n?ralement pas sur le
r?seau, donc pas accessibles. :-(
En ce qui me concerne, je m'occupe de r?cup?rer aupr?s des ?quipes de Berlin
des informations sur BeetleView, l'interface maison de supervision des
caisses (qui sont des "Beetle", ?videmment!), bas?e sur LANDesk System
Manager (anciennement Intel LANDesk Client Manager). La derni?re version de
System Manager est cens?e supporter Linux et se base pour cela sur
lm-sensors, d'o? ma question sur le PC87366...

J'esp?re que cela ?claircit un peu les choses! Je vais essayer de voir si je
peux relancer mes coll?gues, mais nous n'avons d?j? pas assez de machines
nous-m?mes (j'ai acc?s ? un prototype uniquement lorsque nous en pr?parons
un pour un client, donc je partage votre avis sur le fait que l'on teste
beaucoup plus facilement les choses avec le mat?riel), donc ?a m'?tonnerait
qu'il y ait beaucoup de progr?s de ce c?t?-l?. Je vous remercie n?anmoins
pour l'int?r?t que vous avez port? ? mon probl?me ! ;-)

Cordialement,
Elodie BERVAS

>-----Message d'origine-----
>De : Jean Delvare [mailto:khali@linux-fr.org] 
>Envoy? : Tuesday 13 April 2004 11:17
>? : Bervas, Elodie
>Cc : sensors@Stimpy.netroedge.com
>Objet : Re: Information on National Semiconductor chipset PC87366
>
>
>> Je suis d?sol?e de n'avoir pas r?pondu plus t?t ? votre "mesage
>> subliminal"; j'ai essay? de voir aupr?s de mes coll?gues de Berlin
>> s'il ?tait possible de vous pr?ter une de nos machines, mais comme
>> il s'agit d'un prototype, ce n'est pas ?vident.
>
>Je comprends. Notez qu'il n'est pas n?cessaire que ce soit 
>exactement le
>m?me syst?me. Tout syst?me pourvu du m?me composant (PC87366) ou a
>d?faut de son petit fr?re (PC87365) qui est tr?s similaire ferait
>l'affaire.
>
>Et c'?tait juste une suggestion ;) Disons qu'avoir acc?s a un vrai
>composant ?a aide toujours ? ?crire le driver et ? le tester. Les
>sp?cifications c'est bien (surtout celles de National Semiconductor)
>mais ?a ne r?pond pas toujours ? toutes les questions du d?veloppeur.
>
>Notez ?galement qu'un acc?s distant (personnel, bien s?r, via 
>SSH) ? une
>machine similaire pourrait suffire. Un acc?s au compte root est
>toutefois n?cessaire dans ce cas, je ne sais pas comment ?a peut
>s'accorder avec votre politique de s?curit? r?seau.
>
>> Je vous remercie en tout cas de nous signaler cette nouvelle version,
>> je vais transmettre l'information ? mes coll?gues et vous tiendrai
>> au courant de leurs avanc?es l?-dessus.
>
>OK :) La seule personne ayant test? le driver n'avait manifestement pas
>de ventillateurs connect?s sur son PC87366. J'esp?re que vous aurez
>plus de chance, mais ? vrai dire, si c'est vous qui concevez la carte,
>je suppose que vous savez ce que vous faites et que tout sera
>correctement connect? ;)
>
>-- 
>Jean Delvare
>http://www.ensicaen.ismra.fr/~delvare/
>
