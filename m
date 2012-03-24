From: Michael Walle <michael@walle.cc>
Date: Sat, 24 Mar 2012 11:32:17 +0000
Subject: Re: [lm-sensors] bus names and multiple adapters of the same kind
Message-Id: <201203241232.17408.michael@walle.cc>
List-Id: <lm-sensors.vger.kernel.org>
References: <201203240103.34050.michael@walle.cc>
In-Reply-To: <201203240103.34050.michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

> > Unfortunately, this doesn't work if there are two adapters with the same
> > name as on most SoCs :(
> 
> This is an I2C bus driver bug, they shouldn't use the exact same name
> for two adapters. Usually good drivers include something specific in
> each bus name, either an address or an ID. For example I have:

Thank you for the explanation. Actually, this is exactly how i fixed it, 
eg.name the adapter "IBM IIC at <phys offset>".

-- 
Michael

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
