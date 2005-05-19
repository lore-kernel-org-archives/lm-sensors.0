From: ceu@libero.it (Michele Conte - Ceu)
Date: Thu, 19 May 2005 06:23:48 +0000
Subject: sensors.conf hint
Message-Id: <20030219214848.GA1084@debian>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

In the section as99127f-* I've read:
    # does anyone know a board for which the following is correct?
    #   compute temp2 (@*30/43)+25, (@-25)*43/30

Well, with my board (ASUS A7V8X, chipset Via kt400, sensor chip ASB100) the
row above gives correct values of CPU temperature. The default value
(obtained using 'compute temp2 @*2.0, @/2.0') is wrong, 20C higher than
real values.

I'm using lmsensors 2.7.0 and i2c 2.7.0 (w83781d, i2c-viapro) with kernel
2.4.20

Best regards,
Michele Conte
