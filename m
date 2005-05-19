From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:24:03 +0000
Subject: LM83 support
Message-Id: <3F030A23.6070601@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030702090820.2c39fd00.khali@linux-fr.org>
In-Reply-To: <20030702090820.2c39fd00.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I would recommend extending the adm1021 driver.  It's a relatively 
simple driver and not nearly as complex as the w83781d.  And the 
supported chips have fewer differences.

You should probably look at modularizing the extended features somewhat. 
  You can look at my lm85.c driver for an example.

Also, could you change the adm1023 support a bit?  It puts the 
temperature offset value in with the min, max and current values.  But 
this breaks the print routines in sensors.  The temp offset(s) should be 
in their own sysctl.

:v)

Jean Delvare wrote:
> Hi everyone,
> 
> I will add support to LM83 to lm_sensors, as per request from ZOleg
> Matrix <zoleg@matrixc.ru>. This is perfectly what I need to start with
> real driver coding.
> 
> My question now. The LM83 could be supported by the ADM1021 module,
> which already supports ADM1021, ADM1023, MAX1617, MAX1617A, NE1617,
> NE1617A, TMC10, MC1066 and LM84. The LM84 can easily be seen as a light
> version of the LM83. However, I think I remember we decided to avoid
> adding support for new devices to existing drivers. Or is is just true
> for the w83781d?
> 
> I see three possibilities:
> 
> 1* A new driver for the LM83.
> 
> 2* Support for LM83 added to adm1021
> 
> 3* A new driver for the LM83 and move LM84 support to this new driver
> (or any other support combination that would make as much sense as
> possible.
> 
> I did not take a look at the code yet (just read LM83 and LM84
> datasheets (very great BTW) and adm1021 and such detection routine in
> sensors-detect) so I can't say what is technically the best choice.
> However, I suppose that any solution will be easy, so the choice is
> mainly a philosophical one, so to say.
> 
> So, what should we do?
> 



-- 
Philip Pokorny, Director of Engineering
Tel: 415-358-2635   Fax: 415-358-2646   Toll Free: 888-PENGUIN
PENGUIN COMPUTING, INC.
www.penguincomputing.com
