From: david.vanhoose@comcast.net (David van Hoose)
Date: Tue, 09 Aug 2005 22:59:38 +0000
Subject: [lm-sensors] [PATCH 2.6] I2C: Rewrite i2c_probe
Message-Id: <42F9190E.20405@comcast.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050809201755.15962b81.khali@linux-fr.org>
In-Reply-To: <20050809201755.15962b81.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

 From places like below (a snippet from your patch). You use 0 instead 
of  preprocessor tokens. It is also this way in various other places in 
the i2c core code.

// Snippet of i2c_probe_addresses
+	/* Make sure there is something at this address, unless forced */
+	if (kind < 0
+	 && i2c_smbus_xfer(adapter, addr, 0, 0, 0, I2C_SMBUS_QUICK, NULL) < 0)
+		return 0;
+
+	/* Finally call the custom detection function */
+	err = found_proc(adapter, addr, kind);
// Snippet end

IMHO it would make the code a bit less obfuscated.
I can get a patch done by tonight against 2.6.12.4 unless you have 
another source I should try.

Thanks,
David van Hoose


Jean Delvare wrote:
> Hi David,
> 
> 
>>Would it be appreciated if I went through the code and changed the 
>>hardcoded integer constants to actual preprocessor tokens?
> 
> 
> What hardcoded integer constants are you talking about?
> 

