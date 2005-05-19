From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:23:59 +0000
Subject: Call for 2.8.0 soon
Message-Id: <3EE8A199.2040804@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3EE7C67A.4040703@paradyne.com>
In-Reply-To: <3EE7C67A.4040703@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
>>>- libsensors numbering because of binary incompatibility..... go to 
>>>1.5.0 or 2.0.0?
>>
>>What about going with 2.8.0...  Then track the lm_sensors version.
> 
> 
> Why that? There is no reason we number the lib version according to the
> package version. The lib compatibility is unlikely to change that often.

Actually, it is.

Anytime a driver is added to the library, the library version needs to 
change.  This is because the library has compiled in code for every chip 
that it knows about.  And the sensors executable has references to every 
chip that is supported by the matching libsensors.

I think the chances are high that at each release of lm_sensors, at 
least one new driver will be added...

This is also part of my motivation for trying to remove this coupling in 
  the "rewrite" of libsensors...

:v)

-- 
Philip Pokorny, Director of Engineering
Tel: 415-358-2635   Fax: 415-358-2646   Toll Free: 888-PENGUIN
PENGUIN COMPUTING, INC.
www.penguincomputing.com
