From: support-squid@bfinance.fr (jonathan)
Date: Tue, 09 Aug 2005 16:27:41 +0000
Subject: [lm-sensors] bmcsensors and ipmi on Poweredge
Message-Id: <1123604936.4449.6.camel@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
References: <1123503404.3182.14.camel@localhost.localdomain>
In-Reply-To: <1123503404.3182.14.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 2005-08-08 at 13:03 -0400, Yani Ioannou wrote:
> Hi Jonathan,
> 
> It looks like you haven't loaded the ipmi modules, try loading all of
> the ipmi modules before you load i2c-ipmi and bmcsensors and then
> sensors -s, and then try sensors again.
> 
> Yani

thanks Yani, you were right, but it seems that the outputs values are a
little bit strange, aren't they ?

# sensors -s     --> no output ?
# sensors
bmc-i2c-1-00
Adapter: IPMI adapter
in1:       +1.48 V  (min =  +1.56 V, max =  +1.73 V)   
in2:       +1.90 V  (min =  +1.56 V, max =  +1.73 V)   
in3:       +1.90 V  (min =  +1.56 V, max =  +1.73 V)   
in4:       +1.48 V  (min =  +1.56 V, max =  +1.73 V)   
in5:       +1.90 V  (min =  +4.79 V, max =  +5.21 V)   
in6:       +5.08 V  (min = +11.39 V, max = +12.61 V)   
in7:      +11.90 V  (min =  +3.16 V, max =  +3.44 V)   
in8:       +3.27 V  (min =  +2.49 V, max =  +3.28 V)   
in9:       +3.12 V  (min =  +2.42 V, max =  +2.58 V)   
in10:      +2.55 V  (min =  +2.42 V, max =  +2.58 V)   
fan1:     6240 RPM  (min = 1080 RPM)                  
fan2:     6360 RPM  (min = 1080 RPM)                  
fan3:     6240 RPM  (min = 1080 RPM)                  
fan4:     6720 RPM  (min = 1080 RPM)                  
fan5:     6360 RPM  (min = 1080 RPM)                  
fan6:     6240 RPM  (min = 1080 RPM)                  
fan7:     6480 RPM  (min = 1080 RPM)                  
temp1:    -128.0 C  (high =   +80 C, hyst =  -127 C)   
temp2:    -930.0 C  (high =   +80 C, hyst =  -127 C)   
temp3:    -1280.0 C  (high =   +80 C, hyst =  -127 C)   
temp4:    -930.0 C  (high =   +80 C, hyst =  -127 C)   
temp5:    +320.0 C  (high =   +55 C, hyst =  -127 C)   
temp6:    +190.0 C  (high =   +40 C, hyst =  -127 C)   
temp7:    -750.0 C  (high =   +55 C, hyst =  -127 C)   
temp8:    -760.0 C  (high =   +55 C, hyst =  -127 C)   
temp9:    -750.0 C  (high =   +55 C, hyst =  -127 C)   
temp10:   +270.0 C  (high =   +55 C, hyst =  -127 C)   

for example, why temp1 is set to -128.0 C ?   Is there a revolutionnary
coolerator inside ? (joke)

Seriously, must I configure something to get the right values or what's
going on ?

thanks

