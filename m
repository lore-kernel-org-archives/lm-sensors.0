From: ms@plain.de (Markus Schorer)
Date: Thu, 19 May 2005 06:23:45 +0000
Subject: join i2c ml + question
Message-Id: <3E23FF51.3C9851D6@plain.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

hi,

i would like to join the linux-i2c ml.

and my question is: ;-)

i have a i2c controlled chip, that has a "data available" signal.
i've connected it to an interrupt.
how do i service the chip, eg read the data, in/from an interrupt?

is this a case for a bottom half? what options do i have?
what is elegant?

regards,

-- 
_ plain GmbH_______________________________________________________
  markus schorer              fon 089.540.149.0
  daiserstrasse 15 RGB        fax 089.540.149.44
  81371 m?nchen               http://www.plain.de
