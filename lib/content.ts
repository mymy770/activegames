import { type Locale } from './i18n';

export interface Content {
  hero: {
    title: string;
    subtitle: string;
    cta1: string;
    cta2: string;
  };
  concept: {
    title: string;
    description: string;
  };
  games: {
    title: string;
    subtitle: string;
    items: Array<{
      name: string;
      description: string;
      video: string;
    }>;
  };
  pricing: {
    title: string;
    description: string;
  };
  contact: {
    title: string;
    description: string;
    address: string;
    email: string;
    phone: string;
    whatsapp: string;
  };
}

const contentEn: Content = {
  hero: {
    title: 'Active Games',
    subtitle: 'New generation leisure activities\n\nFully immersive interactive arenas, where neon lighting, sound, and physical challenges combine to create unique experiences.',
    cta1: 'Discover our games',
    cta2: 'Discover the concept',
  },
  concept: {
    title: 'About the Game',
    description: `Active Games is a new generation of interactive team challenges, combining physical movement, strategy, and smart technology.

The experience is designed for teams of up to 6 players and lasts 60 minutes of intense action and fun.

From the moment you arrive, each player receives a personal wristband and registers with their name. This wristband tracks your progress, scores, and achievements throughout the entire experience.
Before entering each room, your team scans the wristband to activate the game. Every decision matters — every room, every challenge, every second counts.

The arena features 8 different rooms, each with its own atmosphere, concept, and unique challenges. Every room offers multiple games with several difficulty levels, allowing each team to choose what suits them best.
You can play in competitive mode or team mode — challenge your friends, play together with partners, or compete head-to-head to climb the leaderboard.
There is no fixed path and no predefined order. You choose your strategy, your pace, and your challenges, aiming to score as many points as possible.

Active Games is a dynamic, immersive, and adrenaline-filled experience — where speed, teamwork, and smart decisions are the key to victory.`,
  },
  games: {
    title: 'OUR GAMES',
    subtitle: 'Each game offers a unique experience combining fun, challenge, and physical engagement. Reflexes, coordination, or cooperation: choose your style and dive into the action.',
    items: [
      {
        name: 'Grid',
        description: 'Is a revolutionary interactive flooring system with built-in RGB LED lights and sensors. Designed for gyms, malls, play zones, and theme parks, it creates a dynamic and immersive experience suitable for all ages.',
        video: '/videos/Grille-active-games.mp4',
      },
      {
        name: 'Arena',
        description: 'The ultimate dodgeball LED target wall game. Test speed, accuracy & memory with real-time scoring, tournaments & team challenges',
        video: '/videos/Video-sans-titre-‐-Realisee-avec-Clipchamp-2.mp4',
      },
      {
        name: 'Push',
        description: 'In this room, the walls are filled with buttons that can change different colors, with various game modes that test color recognition and memory abilities, as well as electric current relay and pk game.',
        video: '/videos/PUSH.mp4',
      },
      {
        name: 'Hoops Basketball',
        description: 'An interactive basketball fitness game that combines fun, exercise, and technology—perfect for gyms, homes, and entertainment centers.',
        video: '/videos/Hoops-Basketball.mp4',
      },
      {
        name: 'Climbing',
        description: 'An interactive LED wall designed to test your agility, strategy, and team fun. This attraction combines physical movement with quick thinking.',
        video: '/videos/climb.mp4',
      },
      {
        name: 'Hide Game Room',
        description: 'Cooperate with your friends to complete tasks, avoid the sensors\' detection. Interactive technology with real-time reactions, ensuring an adrenaline filled adventure.',
        video: '/videos/hide-activate.mp4',
      },
      {
        name: 'Flash',
        description: 'Two or more players are required to cooperate. Press the circular light before the randomly decreasing current reaches the target circular light. The current will return and be randomly sent to other players. The higher the level, the faster the current speed.',
        video: '/videos/flash.mp4',
      },
      {
        name: 'Laser',
        description: 'Is a thrilling escape room experience where players dodge laser beams by running, jumping, crawling, and rolling. With multiple game modes.',
        video: '/videos/laser.mp4',
      },
      {
        name: 'Control',
        description: 'In Control, players stand in front of the console and control the movement of the light blocks by tapping the buttons on the console or stepping on the LED tiles.',
        video: '/videos/control.mp4',
      },
    ],
  },
  pricing: {
    title: 'PRICING',
    description: `Unlimited games – 1 Hour – ₪120 per player

Groupe - Events
From 15 participants – ₪130 per player
From 30 participants – ₪120 per player

• Unlimited games for one hour
• Private event room for two hours
• Sound system and lighting
• Game tables
• Unlimited snacks and drinks
• Two slices of pizza per participant`,
  },
  contact: {
    title: 'Contact us',
    description: 'Contact us for any further information or specific inquiries.',
    address: 'Aliyat ha-No\'ar St 1, Rishon LeZion\nInside LASER CITY, 5th Floor',
    email: 'contact@activegames.co.il',
    phone: '03 551-2277',
    whatsapp: '+971585682770',
  },
};

const contentHe: Content = {
  hero: {
    title: 'אקטיב גיימס',
    subtitle: 'פעילויות פנאי דור חדש\n\nזירות אינטראקטיביות סוחפות לחלוטין, שבהן תאורת ניאון, סאונד ואתגרים פיזיים מתחברים ליצירת חוויות ייחודיות.',
    cta1: 'גלו את הקונספט',
    cta2: 'גלו את המשחקים שלנו',
  },
  concept: {
    title: 'על המשחק',
    description: `אקטיב גיימס הוא מתחם משחקים אינטראקטיבי חדשני המבוסס על עבודת צוות, תנועה וחשיבה אסטרטגית.

החוויה מיועדת לקבוצות של עד 6 שחקנים,נהלת לאורך 60 דקות של אקשן.

עם ההגעה, כל שחקן מקבל צמיד חכם ונרשם עם שמו. הצמיד מזהה אתכם לאורך כל המשחק – כל נקודה, כל הישג וכל אתגר נשמרים עליו.
לפני הכניסה לכל חדר, הקבוצה סורקת את הצמיד, והמערכת מזהה אוטומטית את המשתתפים ומפעילה את המשחק הנבחר.

המתחם כולל 8 חדרים שונים, כל אחד עם עולם, קונספט ואתגרים ייחודיים. בכל חדר מחכים מספר משחקים עם רמות קושי משתנות, כך שכל קבוצה יכולה לבחור את האתגרים המתאימים לה.
ניתן לשחק במצב תחרותי או במצב קבוצתי – להתמודד אחד נגד השני או לשתף פעולה עם חברים ושותפים, ולבחור בכל משחק אם לשחק כיריבים או כצוות אחד.
אין מסלול קבוע ואין סדר מחייב – אתם בוחרים לאן להיכנס, מתי להחליף חדר ואיזו אסטרטגיה תוביל אתכם לצבירת מקסימום נקודות.

אקטיב גיימס היא חוויה דינמית, סוחפת ומלאת אדרנלין, שבה שיתוף פעולה, מהירות וחשיבה חדה הם המפתח לניצחון.`,
  },
  games: {
    title: 'המשחקים שלנו',
    subtitle: 'כל משחק מציע חוויה ייחודית שמשלבת הנאה אתגר ומעורבות פיזית, רפלקסים תיאום או שיתוף פעולה. בחר את הסגנון שלך וצא לפעולה:',
    items: [
      {
        name: 'גריד',
        description: 'גריד הוא מערכת רצפה אינטראקטיבית מהפכנית עם תאורת LED RGB וחיישנים מובנים. המערכת מיועדת לחדרי כושר קניונים מתחמי משחק ופארקי נושא. היא יוצרת חוויה דינמית וסוחפת שמתאימה לכל גיל.',
        video: '/videos/Grille-active-games.mp4',
      },
      {
        name: 'ארינה',
        description: 'משחק היעדים האולטימטיבי בכדור־העף־נמנע עם קיר LED. בחן מהירות דיוק וזיכרון עם ניקוד בזמן אמת. טורנירים ואתגרי צוות.',
        video: '/videos/Video-sans-titre-‐-Realisee-avec-Clipchamp-2.mp4',
      },
      {
        name: 'פוש',
        description: 'בחדר הזה הקירות מלאים בכפתורים שיכולים להחליף צבעים. יש מגוון מצבי משחק שבודקים זיהוי צבעים ויכולות זיכרון. בנוסף יש משחקי זרם חשמלי ומשחק PK.',
        video: '/videos/PUSH.mp4',
      },
      {
        name: 'הופס בסקטבול',
        description: 'משחק כדורסל אינטראקטיבי שמשלב כיף פעילות גופנית וטכנולוגיה. מושלם לחדרי כושר בתים ומרכזי בידור.',
        video: '/videos/Hoops-Basketball.mp4',
      },
      {
        name: 'טיפוס',
        description: 'קיר LED אינטראקטיבי שנועד לבדוק זריזות אסטרטגיה ועבודת צוות. האטרקציה משלבת תנועה פיזית עם חשיבה מהירה.',
        video: '/videos/climb.mp4',
      },
      {
        name: 'חדר מחבואים דיגיטל',
        description: 'בחדר הזה עיני חישה עוקבות אחרי כל תנועה שלך. השתמש בעמודים אסטרטגיים למחסה השלם רצפי אור, ועבוד עם הצוות שלך כדי לנצח.',
        video: '/videos/hide-activate.mp4',
      },
      {
        name: 'פלאש',
        description: 'שני שחקנים או יותר צריכים לשתף פעולה. לחץ על מעגל האור לפני שהזרם היורד באקראיות מגיע למעגל היעד.הזרם יחזור ויעבור באקראיות לשחקנים אחרים. ככל שהרמה גבוהה יותר כך מהירות הזרם מהירה יותר',
        video: '/videos/flash.mp4',
      },
      {
        name: 'לייזר',
        description: 'חוויה מרגשת בסגנון חדר בריחה שבה השחקנים מתחמקים מקרני לייזר. בעזרת ריצה קפיצה זחילה והתגלגלות כולל מגוון מצבי משחק.',
        video: '/videos/laser.mp4',
      },
      {
        name: 'קונטרול',
        description: 'בקונטרול, השחקנים עומדים מול הקונסולה ושולטים בתנועת בלוקי האור על ידי הקשה על הכפתורים בקונסולה או דריכה על אריחי ה-LED.',
        video: '/videos/control.mp4',
      },
    ],
  },
  pricing: {
    title: 'מחיר',
    description: `משחקים ללא הגבלה – שעה אחת – ₪100 למשתתף

חבילות אירועים
החל מ-15 משתתפים – ₪130 למשתתף
החל מ-30 משתתפים – ₪120 למשתתף

• משחקים ללא הגבלה שעה אחת
• חדר אירוע פרטי לשעתיים
• הגברה ותאורה
• שולחנות משחק
• חטיפים ושתייה ללא הגבלה
• שני משולשי פיצה לכל משתתף`,
  },
  contact: {
    title: 'צור קשר',
    description: 'צרו איתנו קשר לקבלת מידע נוסף או לשאלות ספציפיות.',
    address: 'עליית הנוער 1, מרכז בר-און – קומה 5 – ראשון לציון\nבמתחם לייזר סיטי',
    email: 'contact@activegames.co.il',
    phone: '03 551-2277',
    whatsapp: '+971585682770',
  },
};

export function getContent(locale: Locale): Content {
  return locale === 'he' ? contentHe : contentEn;
}
