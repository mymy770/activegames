-- Ajouter les templates de Conditions Générales pour les commandes en ligne
-- Ces templates seront affichés quand le client coche la case CGV et inclus dans l'email de confirmation
-- ATTENTION: Si les templates existent déjà, supprimer d'abord avec:
-- DELETE FROM email_templates WHERE code LIKE 'terms_%';

-- Template CGV pour les réservations de jeux (GAME) - Hébreu
INSERT INTO email_templates (code, name, description, subject_template, body_template, is_active, is_system, available_variables)
VALUES (
  'terms_game_he',
  'תנאים והגבלות - משחקים',
  'תנאים כלליים להזמנות משחקים באתר',
  'תנאים והגבלות',
  '
<div style="font-family: Arial, sans-serif; direction: rtl; text-align: right; font-size: 13px; color: #ffffff; line-height: 1.7;">
  <h3 style="color: #00f0ff; margin-bottom: 15px;">תנאים כלליים</h3>

  <p><strong style="color: #00f0ff;">כללי השתתפות (כל הפעילויות):</strong></p>
  <ul style="margin: 10px 0; padding-right: 20px; color: #e0e0e0;">
    <li>ההשתתפות בנעליים סגורות ושטוחות בלבד</li>
    <li>אסורה ההשתתפות לנשים בהריון, חולי אפילפסיה ובעלי קוצבי לב</li>
    <li>החברה שומרת לעצמה את הזכות לבצע משחקים עם פחות משתתפים במקרה של תקלות טכניות</li>
  </ul>

  <hr style="border: none; border-top: 1px solid rgba(0, 240, 255, 0.3); margin: 20px 0;">

  <h4 style="color: #a855f7; margin-bottom: 10px;">🎯 Laser City - לייזר סיטי</h4>
  <ul style="margin: 10px 0; padding-right: 20px; color: #e0e0e0;">
    <li>משך משחק לייזר: 20 דקות נטו + 10-15 דקות של הדרכה והלבשה</li>
    <li>החברה שומרת לעצמה את הזכות להחליט על כמות המשתתפים שנכנסים בו זמנית למשחק</li>
    <li>במידה ומספר המשתתפים בקבוצה גדול מכמות האפודים תבוצע חלוקה לסבבים</li>
  </ul>

  <h4 style="color: #f97316; margin-bottom: 10px;">🎮 Active Games - אקטיב גיימס</h4>
  <ul style="margin: 10px 0; padding-right: 20px; color: #e0e0e0;">
    <li>משך פעילות Active Games: 60 דקות של משחק רציף</li>
    <li>עד 6 שחקנים בו זמנית בכל חדר</li>
    <li>המתחם כולל 8 חדרים אינטראקטיביים שונים</li>
    <li>כל משתתף מקבל צמיד חכם לרישום התוצאות</li>
    <li>ניתן לשחק במצב תחרותי או שיתופי</li>
  </ul>

  <h4 style="color: #14b8a6; margin-bottom: 10px;">🔄 חבילת Mix - לייזר + Active Games</h4>
  <ul style="margin: 10px 0; padding-right: 20px; color: #e0e0e0;">
    <li>משחק לייזר אחד (20 דקות) + 30 דקות Active Games</li>
  </ul>

  <hr style="border: none; border-top: 1px solid rgba(0, 240, 255, 0.3); margin: 20px 0;">

  <p><strong style="color: #00f0ff;">מידע חשוב:</strong></p>
  <ul style="margin: 10px 0; padding-right: 20px; color: #e0e0e0;">
    <li>החברה אינה עובדת עם שוברים</li>
    <li>חל איסור להכניס למקום: קומקום חשמלי, מי-חם, מכשירי חשמל, קונפטי, פנייטות, זיקוקים, בועות סבון, סיגריות ואלכוהול</li>
  </ul>

  <p><strong style="color: #00f0ff;">תנאי תשלום וביטול:</strong></p>
  <ul style="margin: 10px 0; padding-right: 20px; color: #e0e0e0;">
    <li>ביטולים/דחיה: עד 8 ימים לפני - החזר מלא של המקדמה</li>
    <li>7-6 ימים לפני - דמי ביטול של 30%</li>
    <li>5-4 ימים לפני - דמי ביטול של 50%</li>
    <li>3 ימים לפני ופחות - דמי ביטול של 100%</li>
  </ul>

  <p><strong style="color: #00f0ff;">מצב חירום:</strong></p>
  <p style="color: #e0e0e0;">בעת לחימה - אם האיזור יוגדר כאיזור סיכון ע"י פיקוד העורף, האירוע יידחה ויתואם מחדש.</p>
</div>
',
  true,
  true,
  '[]'
)
ON CONFLICT (code) DO UPDATE SET
  body_template = EXCLUDED.body_template,
  updated_at = NOW();

-- Template CGV pour les réservations de jeux (GAME) - Anglais
INSERT INTO email_templates (code, name, description, subject_template, body_template, is_active, is_system, available_variables)
VALUES (
  'terms_game_en',
  'Terms & Conditions - Games',
  'General conditions for online game bookings',
  'Terms & Conditions',
  '
<div style="font-family: Arial, sans-serif; font-size: 13px; color: #ffffff; line-height: 1.7;">
  <h3 style="color: #00f0ff; margin-bottom: 15px;">General Terms & Conditions</h3>

  <p><strong style="color: #00f0ff;">Participation Rules (All Activities):</strong></p>
  <ul style="margin: 10px 0; padding-left: 20px; color: #e0e0e0;">
    <li>Closed and flat shoes are mandatory</li>
    <li>Participation is prohibited for pregnant women, epilepsy patients, and pacemaker users</li>
    <li>The company reserves the right to run games with fewer participants in case of technical issues</li>
  </ul>

  <hr style="border: none; border-top: 1px solid rgba(0, 240, 255, 0.3); margin: 20px 0;">

  <h4 style="color: #a855f7; margin-bottom: 10px;">🎯 Laser City</h4>
  <ul style="margin: 10px 0; padding-left: 20px; color: #e0e0e0;">
    <li>Laser game duration: 20 minutes net + 10-15 minutes for briefing and equipment</li>
    <li>The company reserves the right to decide on the number of participants entering simultaneously</li>
    <li>If the group size exceeds the number of vests, participants will be divided into rounds</li>
  </ul>

  <h4 style="color: #f97316; margin-bottom: 10px;">🎮 Active Games</h4>
  <ul style="margin: 10px 0; padding-left: 20px; color: #e0e0e0;">
    <li>Active Games session duration: 60 minutes of continuous play</li>
    <li>Up to 6 players simultaneously in each room</li>
    <li>The complex includes 8 different interactive rooms</li>
    <li>Each participant receives a smart wristband for score tracking</li>
    <li>Play in competitive or cooperative mode</li>
  </ul>

  <h4 style="color: #14b8a6; margin-bottom: 10px;">🔄 Mix Package - Laser + Active Games</h4>
  <ul style="margin: 10px 0; padding-left: 20px; color: #e0e0e0;">
    <li>One laser game (20 minutes) + 30 minutes of Active Games</li>
  </ul>

  <hr style="border: none; border-top: 1px solid rgba(0, 240, 255, 0.3); margin: 20px 0;">

  <p><strong style="color: #00f0ff;">Important Information:</strong></p>
  <ul style="margin: 10px 0; padding-left: 20px; color: #e0e0e0;">
    <li>The company does not accept vouchers</li>
    <li>Prohibited items: electric kettles, hot water, electrical appliances, confetti, sparklers, fireworks, soap bubbles, cigarettes, and alcohol</li>
  </ul>

  <p><strong style="color: #00f0ff;">Payment and Cancellation Policy:</strong></p>
  <ul style="margin: 10px 0; padding-left: 20px; color: #e0e0e0;">
    <li>Cancellation/postponement: up to 8 days before - full refund of deposit</li>
    <li>7-6 days before - 30% cancellation fee</li>
    <li>5-4 days before - 50% cancellation fee</li>
    <li>3 days or less - 100% cancellation fee</li>
  </ul>

  <p><strong style="color: #00f0ff;">Emergency Situation:</strong></p>
  <p style="color: #e0e0e0;">During wartime - if the area is defined as a risk zone by Home Front Command, the event will be postponed and rescheduled.</p>
</div>
',
  true,
  true,
  '[]'
)
ON CONFLICT (code) DO UPDATE SET
  body_template = EXCLUDED.body_template,
  updated_at = NOW();

-- Template CGV pour les réservations de jeux (GAME) - Français
INSERT INTO email_templates (code, name, description, subject_template, body_template, is_active, is_system, available_variables)
VALUES (
  'terms_game_fr',
  'Conditions Générales - Jeux',
  'Conditions générales pour les réservations de jeux en ligne',
  'Conditions Générales',
  '
<div style="font-family: Arial, sans-serif; font-size: 13px; color: #ffffff; line-height: 1.7;">
  <h3 style="color: #00f0ff; margin-bottom: 15px;">Conditions Générales</h3>

  <p><strong style="color: #00f0ff;">Règles de participation (Toutes activités) :</strong></p>
  <ul style="margin: 10px 0; padding-left: 20px; color: #e0e0e0;">
    <li>Chaussures fermées et plates obligatoires</li>
    <li>Participation interdite aux femmes enceintes, épileptiques et porteurs de pacemaker</li>
    <li>La société se réserve le droit d''organiser des parties avec moins de participants en cas de problèmes techniques</li>
  </ul>

  <hr style="border: none; border-top: 1px solid rgba(0, 240, 255, 0.3); margin: 20px 0;">

  <h4 style="color: #a855f7; margin-bottom: 10px;">🎯 Laser City</h4>
  <ul style="margin: 10px 0; padding-left: 20px; color: #e0e0e0;">
    <li>Durée du jeu laser : 20 minutes nettes + 10-15 minutes de briefing et équipement</li>
    <li>La société se réserve le droit de décider du nombre de participants entrant simultanément</li>
    <li>Si le groupe dépasse le nombre de gilets, les participants seront répartis en tours</li>
  </ul>

  <h4 style="color: #f97316; margin-bottom: 10px;">🎮 Active Games</h4>
  <ul style="margin: 10px 0; padding-left: 20px; color: #e0e0e0;">
    <li>Durée de la session Active Games : 60 minutes de jeu continu</li>
    <li>Jusqu''à 6 joueurs simultanément dans chaque salle</li>
    <li>Le complexe comprend 8 salles interactives différentes</li>
    <li>Chaque participant reçoit un bracelet connecté pour le suivi des scores</li>
    <li>Mode compétitif ou coopératif au choix</li>
  </ul>

  <h4 style="color: #14b8a6; margin-bottom: 10px;">🔄 Forfait Mix - Laser + Active Games</h4>
  <ul style="margin: 10px 0; padding-left: 20px; color: #e0e0e0;">
    <li>Une partie de laser (20 minutes) + 30 minutes d''Active Games</li>
  </ul>

  <hr style="border: none; border-top: 1px solid rgba(0, 240, 255, 0.3); margin: 20px 0;">

  <p><strong style="color: #00f0ff;">Informations importantes :</strong></p>
  <ul style="margin: 10px 0; padding-left: 20px; color: #e0e0e0;">
    <li>La société n''accepte pas les bons de réduction</li>
    <li>Articles interdits : bouilloire électrique, eau chaude, appareils électriques, confettis, cierges magiques, feux d''artifice, bulles de savon, cigarettes et alcool</li>
  </ul>

  <p><strong style="color: #00f0ff;">Conditions de paiement et d''annulation :</strong></p>
  <ul style="margin: 10px 0; padding-left: 20px; color: #e0e0e0;">
    <li>Annulation/report : jusqu''à 8 jours avant - remboursement intégral de l''acompte</li>
    <li>7-6 jours avant - frais d''annulation de 30%</li>
    <li>5-4 jours avant - frais d''annulation de 50%</li>
    <li>3 jours ou moins - frais d''annulation de 100%</li>
  </ul>

  <p><strong style="color: #00f0ff;">Situation d''urgence :</strong></p>
  <p style="color: #e0e0e0;">En cas de conflit - si la zone est définie comme zone à risque par les autorités, l''événement sera reporté et reprogrammé.</p>
</div>
',
  true,
  true,
  '[]'
)
ON CONFLICT (code) DO UPDATE SET
  body_template = EXCLUDED.body_template,
  updated_at = NOW();

-- Template CGV pour les événements (EVENT) - Hébreu
INSERT INTO email_templates (code, name, description, subject_template, body_template, is_active, is_system, available_variables)
VALUES (
  'terms_event_he',
  'תנאים והגבלות - אירועים',
  'תנאים כלליים להזמנות אירועים באתר',
  'תנאים והגבלות - אירועים',
  '
<div style="font-family: Arial, sans-serif; direction: rtl; text-align: right; font-size: 13px; color: #ffffff; line-height: 1.7;">
  <h3 style="color: #00f0ff; margin-bottom: 15px;">תנאים כלליים לאירועים</h3>

  <p><strong style="color: #00f0ff;">כללי השתתפות (כל הפעילויות):</strong></p>
  <ul style="margin: 10px 0; padding-right: 20px; color: #e0e0e0;">
    <li>ההשתתפות בנעליים סגורות ושטוחות בלבד</li>
    <li>אסורה ההשתתפות לנשים בהריון, חולי אפילפסיה ובעלי קוצבי לב</li>
    <li>החברה שומרת לעצמה את הזכות לבצע משחקים עם פחות משתתפים במקרה של תקלות טכניות</li>
  </ul>

  <hr style="border: none; border-top: 1px solid rgba(0, 240, 255, 0.3); margin: 20px 0;">

  <h4 style="color: #a855f7; margin-bottom: 10px;">🎯 Laser City - לייזר סיטי</h4>
  <ul style="margin: 10px 0; padding-right: 20px; color: #e0e0e0;">
    <li>משך משחק לייזר: 20 דקות נטו + 10-15 דקות של הדרכה והלבשה</li>
    <li>החברה שומרת לעצמה את הזכות להחליט על כמות המשתתפים שנכנסים בו זמנית למשחק</li>
    <li>במידה ומספר המשתתפים בקבוצה גדול מכמות האפודים תבוצע חלוקה לסבבים</li>
  </ul>

  <h4 style="color: #f97316; margin-bottom: 10px;">🎮 Active Games - אקטיב גיימס</h4>
  <ul style="margin: 10px 0; padding-right: 20px; color: #e0e0e0;">
    <li>משך פעילות Active Games: 60 דקות של משחק רציף</li>
    <li>עד 6 שחקנים בו זמנית בכל חדר</li>
    <li>המתחם כולל 8 חדרים אינטראקטיביים שונים</li>
    <li>כל משתתף מקבל צמיד חכם לרישום התוצאות</li>
    <li>ניתן לשחק במצב תחרותי או שיתופי</li>
  </ul>

  <h4 style="color: #14b8a6; margin-bottom: 10px;">🔄 חבילת Mix - לייזר + Active Games</h4>
  <ul style="margin: 10px 0; padding-right: 20px; color: #e0e0e0;">
    <li>משחק לייזר אחד (20 דקות) + 30 דקות Active Games</li>
  </ul>

  <hr style="border: none; border-top: 1px solid rgba(0, 240, 255, 0.3); margin: 20px 0;">

  <p><strong style="color: #00f0ff;">תנאי חדר האירוח:</strong></p>
  <ul style="margin: 10px 0; padding-right: 20px; color: #e0e0e0;">
    <li>אין אפשרות להביא כיבוד אם לא הזמנתם חדר</li>
    <li>חדרי אירועים: אין התחייבות לחדר אירוע ספציפי, החברה שומרת לעצמה את הזכות לבחור את שיבוץ החדרים</li>
    <li>שתייה קלה: מוגז/מיץ - בקבוקים 1.5L - טעמים לפי זמינות במלאי / מים בתמי 4</li>
    <li>כיבוד קל: מגוון חטיפים - הטעמים לפי זמינות במלאי</li>
    <li>2 משולשי פיצה למשתתף (ניתן להוסיף מגשים נוספים)</li>
    <li>קישוט החדר - חדרי האירוח מעוצבים. ניתן להביא קישוטים נוספים באופן עצמאי - ללא הדבקה על הקירות</li>
    <li>משחקי שולחן - במקרה של נזק המזמין יישא באחריות מלאה</li>
  </ul>

  <p><strong style="color: #fbbf24;">⚠️ אלרגיות:</strong></p>
  <p style="color: #e0e0e0;">לתשומת ליבכם, ילד בעל אלרגיה מסכנת חיים חייב בליווי מבוגר צמוד אליו. החברה אינה יכולה לקחת אחריות על אלרגיות. אנחנו יכולים לתת הנחייה לא להגיש חטיף כזה או אחר וכמובן לתת לכם בעלי האירוע להחליט אילו חטיפים יוגשו לפני פתיחתם.</p>

  <p><strong style="color: #00f0ff;">תנאי האירוע:</strong></p>
  <ul style="margin: 10px 0; padding-right: 20px; color: #e0e0e0;">
    <li>ניתן לשנות את גודל החבילה עד 3 ימים לפני האירוע</li>
    <li>תחילת אירועים: הלקוח מתבקש להגיע 15 דקות לפני תחילת האירוע, את האורחים יש להזמין לשעה שנקבעה</li>
    <li>הפעילות נתחיל 15 דקות לאחר השעה שנקבעה</li>
    <li>במידה והלקוח יסרב להתחיל את הפעילות, החברה לא מתחייבת לשעה ולכניסה למשחק</li>
    <li>מספר משתתפים באירוע: מינימום 15 משתתפים</li>
    <li>משך האירוע - שעה וחצי/שעתיים - תלוי בסוג הפעילות וכמות המשחקים</li>
  </ul>

  <p><strong style="color: #00f0ff;">מידע חשוב:</strong></p>
  <ul style="margin: 10px 0; padding-right: 20px; color: #e0e0e0;">
    <li>החברה אינה עובדת עם שוברים</li>
    <li>חל איסור להכניס למקום: קומקום חשמלי, מי-חם, מכשירי חשמל, קונפטי, פנייטות, זיקוקים, בועות סבון, סיגריות ואלכוהול</li>
  </ul>

  <p><strong style="color: #00f0ff;">תנאי תשלום וביטול:</strong></p>
  <ul style="margin: 10px 0; padding-right: 20px; color: #e0e0e0;">
    <li>מקדמה - שליש מעלות האירוע, היתרה תשולם ביום האירוע</li>
    <li>הזמנת עבודה תכנס לתוקף רק מעת תשלום מלוא המקדמה</li>
    <li>ביטולים/דחיה: עד 8 ימים לפני - החזר מלא של המקדמה</li>
    <li>7-6 ימים לפני - דמי ביטול של 30%</li>
    <li>5-4 ימים לפני - דמי ביטול של 50%</li>
    <li>3 ימים לפני ופחות - דמי ביטול של 100%</li>
  </ul>

  <p><strong style="color: #00f0ff;">מצב חירום:</strong></p>
  <p style="color: #e0e0e0;">בעת לחימה - אם האיזור יוגדר כאיזור סיכון ע"י פיקוד העורף, האירוע יידחה ויתואם מחדש עד שבועיים מהרגע בו פיקוד העורף הוריד הנחיות מעודכנות המאפשרות לקיים את האירוע.</p>
</div>
',
  true,
  true,
  '[]'
)
ON CONFLICT (code) DO UPDATE SET
  body_template = EXCLUDED.body_template,
  updated_at = NOW();

-- Template CGV pour les événements (EVENT) - Anglais
INSERT INTO email_templates (code, name, description, subject_template, body_template, is_active, is_system, available_variables)
VALUES (
  'terms_event_en',
  'Terms & Conditions - Events',
  'General conditions for online event bookings',
  'Terms & Conditions - Events',
  '
<div style="font-family: Arial, sans-serif; font-size: 13px; color: #ffffff; line-height: 1.7;">
  <h3 style="color: #00f0ff; margin-bottom: 15px;">General Terms & Conditions for Events</h3>

  <p><strong style="color: #00f0ff;">Participation Rules (All Activities):</strong></p>
  <ul style="margin: 10px 0; padding-left: 20px; color: #e0e0e0;">
    <li>Closed and flat shoes are mandatory</li>
    <li>Participation is prohibited for pregnant women, epilepsy patients, and pacemaker users</li>
    <li>The company reserves the right to run games with fewer participants in case of technical issues</li>
  </ul>

  <hr style="border: none; border-top: 1px solid rgba(0, 240, 255, 0.3); margin: 20px 0;">

  <h4 style="color: #a855f7; margin-bottom: 10px;">🎯 Laser City</h4>
  <ul style="margin: 10px 0; padding-left: 20px; color: #e0e0e0;">
    <li>Laser game duration: 20 minutes net + 10-15 minutes for briefing and equipment</li>
    <li>The company reserves the right to decide on the number of participants entering simultaneously</li>
    <li>If the group size exceeds the number of vests, participants will be divided into rounds</li>
  </ul>

  <h4 style="color: #f97316; margin-bottom: 10px;">🎮 Active Games</h4>
  <ul style="margin: 10px 0; padding-left: 20px; color: #e0e0e0;">
    <li>Active Games session duration: 60 minutes of continuous play</li>
    <li>Up to 6 players simultaneously in each room</li>
    <li>The complex includes 8 different interactive rooms</li>
    <li>Each participant receives a smart wristband for score tracking</li>
    <li>Play in competitive or cooperative mode</li>
  </ul>

  <h4 style="color: #14b8a6; margin-bottom: 10px;">🔄 Mix Package - Laser + Active Games</h4>
  <ul style="margin: 10px 0; padding-left: 20px; color: #e0e0e0;">
    <li>One laser game (20 minutes) + 30 minutes of Active Games</li>
  </ul>

  <hr style="border: none; border-top: 1px solid rgba(0, 240, 255, 0.3); margin: 20px 0;">

  <p><strong style="color: #00f0ff;">Event Room Conditions:</strong></p>
  <ul style="margin: 10px 0; padding-left: 20px; color: #e0e0e0;">
    <li>You cannot bring outside food if you did not book a room</li>
    <li>Event rooms: No guarantee of a specific room, the company reserves the right to assign rooms</li>
    <li>Soft drinks: Soda/juice - 1.5L bottles - flavors based on availability / water from dispenser</li>
    <li>Snacks: Variety of snacks - flavors based on availability</li>
    <li>2 pizza slices per participant (additional trays can be ordered)</li>
    <li>Room decoration - rooms are designed. You can bring additional decorations - no wall adhesives</li>
    <li>Board games - in case of damage, the organizer bears full responsibility</li>
  </ul>

  <p><strong style="color: #fbbf24;">⚠️ Allergies:</strong></p>
  <p style="color: #e0e0e0;">Please note, a child with life-threatening allergies must be accompanied by a dedicated adult. The company cannot take responsibility for allergies. We can provide guidance not to serve certain snacks and allow event organizers to decide which snacks will be served before opening them.</p>

  <p><strong style="color: #00f0ff;">Event Conditions:</strong></p>
  <ul style="margin: 10px 0; padding-left: 20px; color: #e0e0e0;">
    <li>Package size can be changed up to 3 days before the event</li>
    <li>Event start: Customer should arrive 15 minutes before the event, guests should be invited for the scheduled time</li>
    <li>Activities will start 15 minutes after the scheduled time</li>
    <li>If the customer refuses to start the activity, the company is not committed to the time and game entry</li>
    <li>Minimum participants for an event: 15 participants</li>
    <li>Event duration - 1.5/2 hours - depends on activity type and number of games</li>
  </ul>

  <p><strong style="color: #00f0ff;">Important Information:</strong></p>
  <ul style="margin: 10px 0; padding-left: 20px; color: #e0e0e0;">
    <li>The company does not accept vouchers</li>
    <li>Prohibited items: electric kettles, hot water, electrical appliances, confetti, sparklers, fireworks, soap bubbles, cigarettes, and alcohol</li>
  </ul>

  <p><strong style="color: #00f0ff;">Payment and Cancellation Policy:</strong></p>
  <ul style="margin: 10px 0; padding-left: 20px; color: #e0e0e0;">
    <li>Deposit - one third of the event cost, balance to be paid on event day</li>
    <li>Work order becomes effective only upon full deposit payment</li>
    <li>Cancellation/postponement: up to 8 days before - full refund of deposit</li>
    <li>7-6 days before - 30% cancellation fee</li>
    <li>5-4 days before - 50% cancellation fee</li>
    <li>3 days or less - 100% cancellation fee</li>
  </ul>

  <p><strong style="color: #00f0ff;">Emergency Situation:</strong></p>
  <p style="color: #e0e0e0;">During wartime - if the area is defined as a risk zone by Home Front Command, the event will be postponed and rescheduled within two weeks from when updated guidelines allowing the event are issued.</p>
</div>
',
  true,
  true,
  '[]'
)
ON CONFLICT (code) DO UPDATE SET
  body_template = EXCLUDED.body_template,
  updated_at = NOW();

-- Template CGV pour les événements (EVENT) - Français
INSERT INTO email_templates (code, name, description, subject_template, body_template, is_active, is_system, available_variables)
VALUES (
  'terms_event_fr',
  'Conditions Générales - Événements',
  'Conditions générales pour les réservations d''événements en ligne',
  'Conditions Générales - Événements',
  '
<div style="font-family: Arial, sans-serif; font-size: 13px; color: #ffffff; line-height: 1.7;">
  <h3 style="color: #00f0ff; margin-bottom: 15px;">Conditions Générales pour les Événements</h3>

  <p><strong style="color: #00f0ff;">Règles de participation (Toutes activités) :</strong></p>
  <ul style="margin: 10px 0; padding-left: 20px; color: #e0e0e0;">
    <li>Chaussures fermées et plates obligatoires</li>
    <li>Participation interdite aux femmes enceintes, épileptiques et porteurs de pacemaker</li>
    <li>La société se réserve le droit d''organiser des parties avec moins de participants en cas de problèmes techniques</li>
  </ul>

  <hr style="border: none; border-top: 1px solid rgba(0, 240, 255, 0.3); margin: 20px 0;">

  <h4 style="color: #a855f7; margin-bottom: 10px;">🎯 Laser City</h4>
  <ul style="margin: 10px 0; padding-left: 20px; color: #e0e0e0;">
    <li>Durée du jeu laser : 20 minutes nettes + 10-15 minutes de briefing et équipement</li>
    <li>La société se réserve le droit de décider du nombre de participants entrant simultanément</li>
    <li>Si le groupe dépasse le nombre de gilets, les participants seront répartis en tours</li>
  </ul>

  <h4 style="color: #f97316; margin-bottom: 10px;">🎮 Active Games</h4>
  <ul style="margin: 10px 0; padding-left: 20px; color: #e0e0e0;">
    <li>Durée de la session Active Games : 60 minutes de jeu continu</li>
    <li>Jusqu''à 6 joueurs simultanément dans chaque salle</li>
    <li>Le complexe comprend 8 salles interactives différentes</li>
    <li>Chaque participant reçoit un bracelet connecté pour le suivi des scores</li>
    <li>Mode compétitif ou coopératif au choix</li>
  </ul>

  <h4 style="color: #14b8a6; margin-bottom: 10px;">🔄 Forfait Mix - Laser + Active Games</h4>
  <ul style="margin: 10px 0; padding-left: 20px; color: #e0e0e0;">
    <li>Une partie de laser (20 minutes) + 30 minutes d''Active Games</li>
  </ul>

  <hr style="border: none; border-top: 1px solid rgba(0, 240, 255, 0.3); margin: 20px 0;">

  <p><strong style="color: #00f0ff;">Conditions de la salle d''événement :</strong></p>
  <ul style="margin: 10px 0; padding-left: 20px; color: #e0e0e0;">
    <li>Vous ne pouvez pas apporter de nourriture extérieure si vous n''avez pas réservé de salle</li>
    <li>Salles d''événements : aucune garantie de salle spécifique, la société se réserve le droit d''attribuer les salles</li>
    <li>Boissons : sodas/jus - bouteilles de 1,5L - parfums selon disponibilité / eau de la fontaine</li>
    <li>Snacks : variété de snacks - parfums selon disponibilité</li>
    <li>2 parts de pizza par participant (plateaux supplémentaires disponibles)</li>
    <li>Décoration - les salles sont décorées. Vous pouvez apporter des décorations supplémentaires - pas de collage sur les murs</li>
    <li>Jeux de société - en cas de dommage, l''organisateur assume l''entière responsabilité</li>
  </ul>

  <p><strong style="color: #fbbf24;">⚠️ Allergies :</strong></p>
  <p style="color: #e0e0e0;">Attention, un enfant souffrant d''allergies potentiellement mortelles doit être accompagné d''un adulte dédié. La société ne peut être tenue responsable des allergies. Nous pouvons vous conseiller de ne pas servir certains snacks et permettre aux organisateurs de décider quels snacks seront servis avant leur ouverture.</p>

  <p><strong style="color: #00f0ff;">Conditions de l''événement :</strong></p>
  <ul style="margin: 10px 0; padding-left: 20px; color: #e0e0e0;">
    <li>La taille du forfait peut être modifiée jusqu''à 3 jours avant l''événement</li>
    <li>Début de l''événement : le client doit arriver 15 minutes avant, les invités doivent être conviés à l''heure prévue</li>
    <li>Les activités commenceront 15 minutes après l''heure prévue</li>
    <li>Si le client refuse de commencer l''activité, la société n''est pas engagée sur l''horaire et l''entrée en jeu</li>
    <li>Nombre minimum de participants : 15 personnes</li>
    <li>Durée de l''événement - 1h30/2h - selon le type d''activité et le nombre de parties</li>
  </ul>

  <p><strong style="color: #00f0ff;">Informations importantes :</strong></p>
  <ul style="margin: 10px 0; padding-left: 20px; color: #e0e0e0;">
    <li>La société n''accepte pas les bons de réduction</li>
    <li>Articles interdits : bouilloire électrique, eau chaude, appareils électriques, confettis, cierges magiques, feux d''artifice, bulles de savon, cigarettes et alcool</li>
  </ul>

  <p><strong style="color: #00f0ff;">Conditions de paiement et d''annulation :</strong></p>
  <ul style="margin: 10px 0; padding-left: 20px; color: #e0e0e0;">
    <li>Acompte - un tiers du coût de l''événement, solde à payer le jour de l''événement</li>
    <li>La commande n''est effective qu''après paiement complet de l''acompte</li>
    <li>Annulation/report : jusqu''à 8 jours avant - remboursement intégral de l''acompte</li>
    <li>7-6 jours avant - frais d''annulation de 30%</li>
    <li>5-4 jours avant - frais d''annulation de 50%</li>
    <li>3 jours ou moins - frais d''annulation de 100%</li>
  </ul>

  <p><strong style="color: #00f0ff;">Situation d''urgence :</strong></p>
  <p style="color: #e0e0e0;">En cas de conflit - si la zone est définie comme zone à risque par les autorités, l''événement sera reporté et reprogrammé dans les deux semaines suivant la levée des restrictions.</p>
</div>
',
  true,
  true,
  '[]'
)
ON CONFLICT (code) DO UPDATE SET
  body_template = EXCLUDED.body_template,
  updated_at = NOW();
