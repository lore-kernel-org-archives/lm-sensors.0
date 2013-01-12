From: Andreas Mohr <andi@lisas.de>
Date: Sat, 12 Jan 2013 11:47:59 +0000
Subject: [lm-sensors] lm-sensors.org website usability trouble
Message-Id: <20130112114759.GA11703@rhlx01.hs-esslingen.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,

I have to admit I've had somewhat more trouble with the
already rather old (=3D~ mature?) lm-sensors project than I expected.

Thus I'm now writing with a list of suggestions that I believe are missing
and could be helpful:

- as mentioned on http://trac.edgewall.org/ticket/2908 ,
  "Oh... and I also have a great big bold piece of text on the main wiki pa=
ge
   telling users how to log in and create a ticket."
  Well... user registration is an all-too-frequent PITA with Trac -
  and lm-sensors.org doesn't seem to have that *BOLD* notification text,
  thus people are left frantically searching for Trac user authorization
  (e.g. for simple purposes of Wiki editing, NOT other Trac stuff!) back & =
fro
  and wasting sizeable amounts of time finding nothing.
  Creating logins seems to be disabled by the site admin -
  without the subsequently obviously *required* prominent explanation
  (since Trac does not itself provide an explanation according to privilege=
 restrictions level).
  http://www.lm-sensors.org/wiki/FAQ/Chapter5 does not contain this hint.
  Neither does http://www.lm-sensors.org/wiki/ProjectInformation ,
  or http://www.lm-sensors.org/wiki/FeedbackAndSupport

- since I couldn't sufficiently easily gain authorization
  to subsequently do the Wiki changes that I wanted to
  (with no text explaining *why* this is the case), I'm listing them here:
  on http://www.lm-sensors.org/wiki/Configurations:
  it's a bit questionable why the list of foreign configuration file URLs
  is provided by http://www.lm-sensors.org/wiki/UsefulLinks
  rather than by this page directly (or perhaps one wants to force the
  focus on extending lm-sensors' config database
  rather than external uncontrolled sources? understandable...).
  Possibly one should add
  "Once you managed to verify that these configurations are working nicely,
  please work towards having them added to the Configurations here,
  by editing/submitting/... yadda.",
  but this might be problematic due to authorship/copyright issue
  due to originally fetching the configuration from external sites.

In contrast to the very important usability items such as user login questi=
ons,
the license change page ( http://www.lm-sensors.org/wiki/LibsensorsLicense )
seems to be perfect, providing a list of contributor results
and a clarifying license table post-change. A pity since the average
(contributing?) visitor of your site prolly ain't interested in license cha=
nges ;)

Otherwise thank you very much for a very important and massive project
(implementing all the many sensors and maintaining I2C range data
and configurations etc. surely must have been a lot of work!).

Andreas Mohr

--=20
=BFumop apisdn upside down?
(by daniweb.com user Bench)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
