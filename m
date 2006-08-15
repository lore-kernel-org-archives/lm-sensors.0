From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Tue, 15 Aug 2006 03:17:10 +0000
Subject: [lm-sensors] [RFC PATCH 2.6.18-rc4-mm1] hwmon: unchecked return
Message-Id: <20060815031710.GB2666@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060814020407.GA3327@jupiter.solarsys.private>
In-Reply-To: <20060814020407.GA3327@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Jean Delvare <khali at linux-fr.org> [2006-08-14 15:02:21 +0200]:
> 	if (kind != w83697hf) {
> 		if ((err = device_create_file(&new_client->dev,
> 					&dev_attr_in1_input))
> 		 || (err = device_create_file(&new_client->dev,
> 					&dev_attr_in1_min))
> 		 || (err = device_create_file(&new_client->dev,
> 					&dev_attr_in1_max)))
> 			goto ERROR4;
> 	}
> 
> More concise and it works just as fine, doesn't it? Same applies below.

Agreed.

> Maybe you can also group the two (kind != w83697hf) blocks?

I already combined one (compared to original code)... so, yeah.

Regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com


