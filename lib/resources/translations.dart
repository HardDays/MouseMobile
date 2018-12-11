import '../models/api/preferences.dart';

class Translations {

  static String locale = Language.engilsh;

  static Map <String, Map <String, String>> words = {

    Language.engilsh: {
      
      'campaingToBring': 'CAMPAIGN TO BRING\n YOUR FAVE ARTISTS\n CLOSER TO YOU',
      'watchLiveShows': 'WATCH LIVE SHOWS\n IN 360°\n VIRTUAL REALITY',
      'discoverMusic': 'DISCOVER MUSIC\n SHARE SHOWS\n GET REWARDS',
      'login': 'Login',
      'signUp': 'Sign Up',
      'continueAsGuest': 'Continue as guest',
      'loginWith': 'Login with',
      'mouse': 'Mouse',
      'search': 'Search',
      'username': 'Username',
      'password': 'Password',
      'forgotYourPassword': 'Forgot your password',
      'email': 'Email',
      'restore': 'restore',
      'firstName': 'First name',
      'lastName': 'Last name',
      'confirmPassword': 'Confirm password',
      'enterEmail': 'Enter the email address you used when you created your account.',
      'checkEmail': 'Check your email',
      'weSentInstruction': 'We sent you instructions on how to recover your password.',
      'continue': 'Continue',
      'funded': 'Funded',
      'profile': 'Profile',
      'shows': 'Shows',
      'emptyUsername': 'Empty username',
      'emptyPassword': 'Empty password',
      'serverNotRepsonding': 'Server not responding',
      'pleaseTryAgain': 'Please, try again later',
      'unauthorized': 'Unauthorized',
      'ok': 'OK',
      'wrongUsernameOrPass': 'Wrong username or password',
      'wrongEmailFormat': 'Wrong email format',
      'wrongPassSize': 'Enter more than 6 symbols',
      'wrongPassSymbols': 'Only letters, numbers and symbols _-. allowed',
      'passwordsNotMatched': 'Passwords not matched',
      'wrongUsernameSize': 'Username can be from 3 to 30 symbols',
      'wrongUsernameSymbols': 'Only letters, numbers and symbols _. allowed',
      'wrongNameSize': 'Name can be from 1 to 50 symbols',
      'cannotRegister': 'Cannot register',
      'emailAlreadyTaken': 'Email already taken',
      'usernameAlreadyTaken': 'Username already taken',
      'wrongPhoneFormat': 'Wrong phone format',
      'promo': 'PROMO',
      'startingFrom': 'Starting from',
      'buyTicket': 'Buy ticket',
      'feed': 'Feed',
      'unnamed': 'Unnamed',
      'to': 'to',
      'addedImage': 'Added image',
      'addedVideo': 'Added video',
      'changed': 'Changed',
      'of': 'of',
      'addedGenre': 'Added genre',
      'addedNewTicket': 'Added new ticket',
      'launchedEvent': 'Launched event',
      'noFeedUpdates': 'No feed updates',
      'save': 'Save',
      'closed': 'Closed',
      'dismiss': 'Dismiss',
      'distanceAround': 'Distance around',
      'ticketType': 'Ticket type',
      'venueType': 'Venue type',
      'appPreferences': 'App Preferences',
      'regionalOptions': 'Regional options',
      'language': 'Language',
      'date': 'Date',
      'dateFormat': 'Date format',
      'distance': 'Distance',
      'currency': 'Currency',
      'time': 'Time',
      '12hour': '12 hour',
      '24hour': '24 hour',
      'feedback': 'Feedback',
      'tellingYou': 'I\'m telling you about',
      'aBug': 'A Bug',
      'anEnchancement': 'An Enchancement',
      'compliment': 'Compliment',
      'details': 'Details',
      'howAreWe': 'How are we doing',
      'pleaseRateUs': 'Please Rate Us',
      'loginInfo': 'Login Info',
      'phoneNumber': 'Phone number',
      'notifications': 'Notifications',
      'showsAndMessages': 'Shows and messages',
      'newShowsNear': 'New Shows Near You',
      'newShowsFavorite': 'New Shows From Favorite Artist',
      'messagesToYou': 'Messages Sent to You',
      'showsNotificationsHistory': 'Shows notifications history',
      'daily': 'Daily',
      'weekly': 'Weekly',
      'monthly': 'Monthly',
      'settings': 'Settings',
      'rewards': 'Rewards',
      'customerSupport': 'Customer Support',
      'termsOfService': 'Terms of Service',
      'privacyPolicy': 'Privacy Policy',
      'shareMouse': 'Share MOUSE With Others',
      'logout': 'Log Out',
      'version': 'Version 1.0',
      'cantLoadAccount': 'Can\'t load account',
      'accountIsSuspended': 'Account is suspended',
      'account': 'Account',
      'noMedia': 'No media',
      'upcomingShows': 'Upcoming shows',
      'media': 'Media',
      'noFavorites': 'No favorites',
      'noCampaigns': 'No campaigns',
      'favorites': 'Favorites',
      'campaigns': 'Campaigns',
      'followers': 'Followers',
      'following': 'Following',
      'noFollowers': 'No followers',
      'noFollowing': 'No following',
      'success': 'Success',
      'profileUpdated': 'Profile has been updated', 
      'cannotUpdate': 'Cannot update profile',
      'usernameTaken': 'Username already taken',
      'editProfile': 'Edit profile',
      'enterUsername': 'Enter username',
      'enterBio': 'Enter bio',
      'bio': 'Bio',
      'noRewards': 'No rewards',
      'noUpcomingShows': 'No upcoming shows',
      'contactInfo': 'Contact info',
      'fax': 'Fax',
      'officeHours': 'Office hours', 
      'operatingHours': 'Operating hours', 
      'ticketsWereAdded': 'Tickets were added', 
      'unknownError': 'Unknown error', 
      'error': 'Error', 
      'creditCard': 'Credit Card', 
      'paypal': 'PayPal', 
      'expiryDate': 'Expiry Date', 
      'cvv': 'CVV', 
      'cardHolder': 'Card Holder Name', 
      'pay': 'Pay', 
      'payWithPaypal': 'Pay with paypal', 
      'paymentMethod': 'Payment method', 
      'total': 'Total', 
      'fans': 'Fans', 
      'artists': 'Artists', 
      'venues': 'Venues', 
      'noTicketsLeft': 'No tickets left', 
      'pleaseSelectTickets': 'Please, select another tickets', 
      'emptyCart': 'Empty cart', 
      'noTickets': 'No tickets', 
      'general': 'General', 
      'special': 'Special', 
      'regular': 'Regular', 
      'soldOut': 'Sold out', 
      'buyTickets': 'Buy tickets', 
      'noArtists': 'No artists', 
      'video': 'Video', 
      'photos': 'Photos', 
      'loading': 'Loading', 
      'addComment': 'Add comment', 
      'noComments': 'No comments', 
      'showPreview': 'Show preview', 
      'goal': 'Goal',
      'backers': 'Backers',
      'daysToGo': 'Days to go', 
      'finished': 'Finished', 
      'tickets': 'Tickets', 
      'info': 'Info', 
      'comments': 'Comments', 
      'location': 'Location', 
      'otherFilters': 'Other filters', 
      'noShowsFound': 'No shows found', 
      'upcoming': 'Upcoming', 
      'past': 'Past', 
      'follow': 'Follow', 
      'unfollow': 'Unfollow', 
      'ticket': 'Ticket',
      'pleaseLogin': 'Please, log in for this action',
      'map': 'Map',
      'yes': 'Yes',
      'no': 'No',
      'textUSD': 'Dollar (\$)',
      'textRUB': 'Ruble (₽)',
      'textEUR': 'Euro (€)',

      'emailUpdated': 'Email successfully updated',
      'changeEmail': 'Change email',
      'currentEmail': 'Current email',
      'update': 'Update',
      'passwordUpdated': 'Password successfully updated',
      'wrongCurrentPassword': 'Wrong current password',
      'changePassword': 'Change Password',
      'currentPassword': 'Current password',
      'newPassword': 'New password',
      'confrimPassword': 'Confirm password',
      'phoneUpdated': 'Phone successfully updated',
      'phoneAlreadyTaken': 'Phone already taken',
      'changePhone': 'Change phone',
      'currentPhone': 'Current phone',
      'newPhone': 'New phone',
      'thankForQuestion': 'Thank you for your question!',
      'top5Questions': 'Top 5 questions',
      'sendAQuestion': 'Send a question',
      'howToCreateEvent': 'How to Create an Event',
      'createEventAnswer': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Mattis nunc sed blandit libero volutpat sed cras ornare. Volutpat sed cras ornare arcu dui. In tellus integer feugiat scelerisque varius morbi enim nunc faucibus. Elit sed vulputate mi sit amet mauris. Condimentum vitae sapien pellentesque habitant morbi tristique. Et egestas quis ipsum suspendisse. Sagittis vitae et leo duis ut diam quam nulla porttitor. Urna id volutpat lacus laoreet non curabitur gravida. Sed vulputate mi sit amet. Risus viverra adipiscing at in tellus integer feugiat scelerisque varius. Nunc mattis enim ut tellus elementum sagittis vitae. Lorem dolor sed viverra ipsum nunc aliquet bibendum. Malesuada proin libero nunc consequat. Felis eget nunc lobortis mattis. Fermentum et sollicitudin ac orci phasellus egestas tellus rutrum tellus. Vitae proin sagittis nisl rhoncus mattis rhoncus urna neque viverra. At urna condimentum mattis pellentesque id nibh tortor id. Vulputate ut pharetra sit amet aliquam id diam maecenas. Tellus at urna condimentum mattis pellentesque id nibh tortor. Nulla facilisi etiam dignissim diam. A cras semper auctor neque vitae tempus quam. ',
      'howToCreateCrowdfunding': 'How to Create a Crowdfunding Event',
      'createCrowdfundingAnswer': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Mattis nunc sed blandit libero volutpat sed cras ornare. Volutpat sed cras ornare arcu dui. In tellus integer feugiat scelerisque varius morbi enim nunc faucibus. Elit sed vulputate mi sit amet mauris. Condimentum vitae sapien pellentesque habitant morbi tristique. Et egestas quis ipsum suspendisse. Sagittis vitae et leo duis ut diam quam nulla porttitor. Urna id volutpat lacus laoreet non curabitur gravida. Sed vulputate mi sit amet. Risus viverra adipiscing at in tellus integer feugiat scelerisque varius. Nunc mattis enim ut tellus elementum sagittis vitae. Lorem dolor sed viverra ipsum nunc aliquet bibendum. Malesuada proin libero nunc consequat. Felis eget nunc lobortis mattis. Fermentum et sollicitudin ac orci phasellus egestas tellus rutrum tellus. Vitae proin sagittis nisl rhoncus mattis rhoncus urna neque viverra. At urna condimentum mattis pellentesque id nibh tortor id. Vulputate ut pharetra sit amet aliquam id diam maecenas. Tellus at urna condimentum mattis pellentesque id nibh tortor. Nulla facilisi etiam dignissim diam. A cras semper auctor neque vitae tempus quam. ',
      'howToSearch': 'How to Search for a Show in my Area',
      'searchAnswer': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Mattis nunc sed blandit libero volutpat sed cras ornare. Volutpat sed cras ornare arcu dui. In tellus integer feugiat scelerisque varius morbi enim nunc faucibus. Elit sed vulputate mi sit amet mauris. Condimentum vitae sapien pellentesque habitant morbi tristique. Et egestas quis ipsum suspendisse. Sagittis vitae et leo duis ut diam quam nulla porttitor. Urna id volutpat lacus laoreet non curabitur gravida. Sed vulputate mi sit amet. Risus viverra adipiscing at in tellus integer feugiat scelerisque varius. Nunc mattis enim ut tellus elementum sagittis vitae. Lorem dolor sed viverra ipsum nunc aliquet bibendum. Malesuada proin libero nunc consequat. Felis eget nunc lobortis mattis. Fermentum et sollicitudin ac orci phasellus egestas tellus rutrum tellus. Vitae proin sagittis nisl rhoncus mattis rhoncus urna neque viverra. At urna condimentum mattis pellentesque id nibh tortor id. Vulputate ut pharetra sit amet aliquam id diam maecenas. Tellus at urna condimentum mattis pellentesque id nibh tortor. Nulla facilisi etiam dignissim diam. A cras semper auctor neque vitae tempus quam. ',
      'howToUploadVideo': 'How to Upload my Videos (Artist)',
      'uploadVideoAnswer': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Mattis nunc sed blandit libero volutpat sed cras ornare. Volutpat sed cras ornare arcu dui. In tellus integer feugiat scelerisque varius morbi enim nunc faucibus. Elit sed vulputate mi sit amet mauris. Condimentum vitae sapien pellentesque habitant morbi tristique. Et egestas quis ipsum suspendisse. Sagittis vitae et leo duis ut diam quam nulla porttitor. Urna id volutpat lacus laoreet non curabitur gravida. Sed vulputate mi sit amet. Risus viverra adipiscing at in tellus integer feugiat scelerisque varius. Nunc mattis enim ut tellus elementum sagittis vitae. Lorem dolor sed viverra ipsum nunc aliquet bibendum. Malesuada proin libero nunc consequat. Felis eget nunc lobortis mattis. Fermentum et sollicitudin ac orci phasellus egestas tellus rutrum tellus. Vitae proin sagittis nisl rhoncus mattis rhoncus urna neque viverra. At urna condimentum mattis pellentesque id nibh tortor id. Vulputate ut pharetra sit amet aliquam id diam maecenas. Tellus at urna condimentum mattis pellentesque id nibh tortor. Nulla facilisi etiam dignissim diam. A cras semper auctor neque vitae tempus quam. ',
      'howToFindArtist': 'How to Find My Favorite Artist',
      'findArtistAnswer': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Mattis nunc sed blandit libero volutpat sed cras ornare. Volutpat sed cras ornare arcu dui. In tellus integer feugiat scelerisque varius morbi enim nunc faucibus. Elit sed vulputate mi sit amet mauris. Condimentum vitae sapien pellentesque habitant morbi tristique. Et egestas quis ipsum suspendisse. Sagittis vitae et leo duis ut diam quam nulla porttitor. Urna id volutpat lacus laoreet non curabitur gravida. Sed vulputate mi sit amet. Risus viverra adipiscing at in tellus integer feugiat scelerisque varius. Nunc mattis enim ut tellus elementum sagittis vitae. Lorem dolor sed viverra ipsum nunc aliquet bibendum. Malesuada proin libero nunc consequat. Felis eget nunc lobortis mattis. Fermentum et sollicitudin ac orci phasellus egestas tellus rutrum tellus. Vitae proin sagittis nisl rhoncus mattis rhoncus urna neque viverra. At urna condimentum mattis pellentesque id nibh tortor id. Vulputate ut pharetra sit amet aliquam id diam maecenas. Tellus at urna condimentum mattis pellentesque id nibh tortor. Nulla facilisi etiam dignissim diam. A cras semper auctor neque vitae tempus quam. ',
      'subject': 'Subject',
      'message': 'Message',
      'send': 'Send',
      'noSubject': 'No subject',
      'noMessage': 'No message',
      'thankForFeedback': 'Thank you for your feedback!',
      'mouseTerms': 'Mouse terms of service',
      'mousePrivacy': 'Mouse privacy policy',
      'termsText': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Mattis nunc sed blandit libero volutpat sed cras ornare. Volutpat sed cras ornare arcu dui. In tellus integer feugiat scelerisque varius morbi enim nunc faucibus. Elit sed vulputate mi sit amet mauris. Condimentum vitae sapien pellentesque habitant morbi tristique. Et egestas quis ipsum suspendisse. Sagittis vitae et leo duis ut diam quam nulla porttitor. Urna id volutpat lacus laoreet non curabitur gravida. Sed vulputate mi sit amet. Risus viverra adipiscing at in tellus integer feugiat scelerisque varius. Nunc mattis enim ut tellus elementum sagittis vitae. Lorem dolor sed viverra ipsum nunc aliquet bibendum. Malesuada proin libero nunc consequat. Felis eget nunc lobortis mattis. Fermentum et sollicitudin ac orci phasellus egestas tellus rutrum tellus. Vitae proin sagittis nisl rhoncus mattis rhoncus urna neque viverra. At urna condimentum mattis pellentesque id nibh tortor id. Vulputate ut pharetra sit amet aliquam id diam maecenas. Tellus at urna condimentum mattis pellentesque id nibh tortor. Nulla facilisi etiam dignissim diam. A cras semper auctor neque vitae tempus quam. ',
      'privacyText': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Mattis nunc sed blandit libero volutpat sed cras ornare. Volutpat sed cras ornare arcu dui. In tellus integer feugiat scelerisque varius morbi enim nunc faucibus. Elit sed vulputate mi sit amet mauris. Condimentum vitae sapien pellentesque habitant morbi tristique. Et egestas quis ipsum suspendisse. Sagittis vitae et leo duis ut diam quam nulla porttitor. Urna id volutpat lacus laoreet non curabitur gravida. Sed vulputate mi sit amet. Risus viverra adipiscing at in tellus integer feugiat scelerisque varius. Nunc mattis enim ut tellus elementum sagittis vitae. Lorem dolor sed viverra ipsum nunc aliquet bibendum. Malesuada proin libero nunc consequat. Felis eget nunc lobortis mattis. Fermentum et sollicitudin ac orci phasellus egestas tellus rutrum tellus. Vitae proin sagittis nisl rhoncus mattis rhoncus urna neque viverra. At urna condimentum mattis pellentesque id nibh tortor id. Vulputate ut pharetra sit amet aliquam id diam maecenas. Tellus at urna condimentum mattis pellentesque id nibh tortor. Nulla facilisi etiam dignissim diam. A cras semper auctor neque vitae tempus quam. ',
      'newEmail': 'New email',
      'shareYourCode': 'Share your code',
      'getYourFriends': 'Get your friends to use your code when joining Mouse or purchasing tickets to shows.',
      'moreFriends': 'The more friends join or buy tickets using your code, the bigger your rewards are.',
      'shareIn': 'Share in',
      'share': 'Share',
      'pleaseSelectFeedback': 'Please, select feedback type',
      'pleaseRate': 'Please, rate our app',
      'reset': 'Reset',
      // enums

      'fan': 'Fan',
      'artist': 'Artist',
      'venue': 'Venue',
      'vr': 'VR',
      'in_person': 'In person',
      'blues': 'Blues',
      'children_music': 'Children music',
      'classical': 'Classical',
      'country': 'Country',
      'electronic': 'Electronic',
      'holiday': 'Holiday',
      'opera': 'Opera',
      'singer': 'Singer',
      'latino': 'Latino',
      'jazz': 'Jazz',
      'pop': 'Pop',
      'soul': 'Soul',
      'musicals': 'Musicals',
      'dance': 'Dance',
      'world': 'World',
      'hip_hop': 'Hip hop',
      'alternative': 'Alternative',
      'christian_gospel': 'Christian gospel',
      'rock': 'Rock',
      'vocal': 'Vocal',
      'reggae': 'Reggae',
      'easy_listening': 'Easy listening',
      'j_pop': 'J-pop',
      'enka': 'Enka',
      'anime': 'Anime',
      'kayokyoku': 'Kayokyoku',
      'k_pop': 'K-pop',
      'karaoke': 'Karaoke',
      'instrumental': 'Instrumental',
      'brazilian': 'Brazilian',
      'spoken_word': 'Spoken word',
      'disney': 'Disney',
      'french_pop': 'French pop',
      'german_pop': 'German pop',
      'german_folk': 'German folk',
      'new_age': 'New age',
      'night_club': 'Night club',
      'concert_hall': 'Concert hall',
      'event_space': 'Event space',
      'additional_room': 'Additional room',
      'theatre': 'Theatre',
      'other': 'Other',
      'stadium_arena': 'Stadium arena',
      'outdoor_space': 'Outdoor space',
      'restaurant': 'Restaurant',
      'bar': 'Bar',
      'private_residence': 'Private residence',


      //fields

      'description': 'Description',
      'address': 'Address',
      'phone': 'Phone',
      'about': 'About',
      'user_name': 'Username',
      'display_name': 'Name',
      'stage_name': 'Stage name',
      'genre': 'Genre',

      //weekdays

      'Sunday': 'Sunday',
      'Monday': 'Monday',
      'Tuesday': 'Tuesday',
      'Wednesday': 'Wednesday',
      'Thursday': 'Thursday',
      'Friday': 'Friday',
      'Saturday': 'Saturday',

      'sunday': 'Sunday',
      'monday': 'Monday',
      'tuesday': 'Tuesday',
      'wednesday': 'Wednesday',
      'thursday': 'Thursday',
      'friday': 'Friday',
      'saturday': 'Saturday',

      //months

      'September': 'September',
      'October': 'October',
      'November': 'November',
      'December': 'December',
      'January': 'January',
      'February': 'February',
      'March': 'March',
      'April': 'April',
      'May': 'May',
      'June': 'June',
      'July': 'July',
      'August': 'August',

      // dist

      'km': 'Km',
      'mi': 'Miles',

      // currency

      'USD': '\$',
      'EUR': '€',
      'RUB': '₽',

      // lang

      'en': 'English',
      'ru': 'Russian',
    },
    
    Language.russian: {
      'campaingToBring': 'CAMPAIGN TO BRING\n YOUR FAVE ARTISTS\n CLOSER TO YOU',
      'watchLiveShows': 'WATCH LIVE SHOWS\n IN 360°\n VIRTUAL REALITY',
      'discoverMusic': 'DISCOVER MUSIC\n SHARE SHOWS\n GET REWARDS',
      'login': 'Вход',
      'signUp': 'Регистрация',
      'continueAsGuest': 'Войти как гость',
      'loginWith': 'Войти с',
      'mouse': 'Mouse',
      'username': 'Юзернейм',
      'password': 'Пароль',
      'forgotYourPassword': 'Забыли пароль?',
      'email': 'Почта',
      'restore': 'Восстановить',
      'firstName': 'Имя',
      'lastName': 'Фамилия',
      'confirmPassword': 'Подтвердить пароль',
      'enterEmail': 'Введите почту, которую использовали при регистрации',
      'checkEmail': 'Проверьте Вашу почту',
      'weSentInstruction': 'Мы отправили инструкцию по восстановлению на Вашу почту',
      'continue': 'Продолжить',
      'funded': 'Собрано',
      'profile': 'Профиль',
      'shows': 'Шоу',
      'emptyUsername': 'Пустой юзернейм',
      'emptyPassword': 'Пустой пароль',
      'serverNotRepsonding': 'Сервер не отвечает',
      'pleaseTryAgain': 'Пожалуйста, повторите позже',
      'unauthorized': 'Не авторизован',
      'ok': 'ОК',
      'wrongUsernameOrPass': 'Неверный логин или пароль',
      'wrongEmailFormat': 'Неверная почта',
      'wrongPassSize': 'Введите более 6 символов',
      'wrongPassSymbols': 'Введите буквы, цифры или символы _-.',
      'passwordsNotMatched': 'Пароли не совпадают',
      'wrongUsernameSize': 'Введите от 3 до 30 символов',
      'wrongUsernameSymbols': 'Введите буквы, цифры или символы _.',
      'wrongNameSize': 'Имя не может быть пустым',
      'cannotRegister': 'Ошибка',
      'emailAlreadyTaken': 'Почта уже занята',
      'usernameAlreadyTaken': 'Юзернейм используется',
      'wrongPhoneFormat': 'Wrong phone format',
      'promo': 'PROMO',
      'startingFrom': 'От',
      'buyTicket': 'Купить',
      'feed': 'Новости',
      'unnamed': 'Безымянный',
      'to': 'в',
      'addedImage': 'Добавлено фото',
      'addedVideo': 'Добавлено видео',
      'changed': 'Изменено',
      'of': '',
      'addedGenre': 'Добавлен жанр',
      'addedNewTicket': 'Добавлен билет',
      'launchedEvent': 'Запущено шоу',
      'noFeedUpdates': 'Нет обновлений',
      'save': 'Сохранить',
      'closed': 'Закрыто',
      'dismiss': 'Ок',
      'distanceAround': 'Радиус',
      'ticketType': 'Тип билета',
      'venueType': 'Тип места',
      'appPreferences': 'Настройки',
      'regionalOptions': 'Язык и дата',
      'language': 'Язык',
      'date': 'Дата',
      'dateFormat': 'Формат даты',
      'distance': 'Расстояние',
      'currency': 'Валюта',
      'time': 'Время',
      '12hour': '12 часовой',
      '24hour': '24 часовой',
      'feedback': 'Отзывы',
      'tellingYou': 'Я сообщу вам о',
      'aBug': 'Ошибке',
      'anEnchancement': 'Улучшении',
      'compliment': 'Дополнении',
      'details': 'Детали',
      'howAreWe': 'Как вам наша работа?',
      'pleaseRateUs': 'Оцените приложение',
      'loginInfo': 'Информация о логине',
      'phoneNumber': 'Телефонный номер',
      'notifications': 'Уведомления',
      'showsAndMessages': 'Шоу и сообщения',
      'newShowsNear': 'Новые шоу рядом с вами',
      'newShowsFavorite': 'Новые шоу любимых исполнителей',
      'messagesToYou': 'Новые сообщения',
      'showsNotificationsHistory': 'Частота уведомлений',
      'daily': 'День',
      'weekly': 'Неделя',
      'monthly': 'Месяц',
      'settings': 'Настройки',
      'rewards': 'Вознаграждение',
      'customerSupport': 'Поддержка',
      'termsOfService': 'Условия обслуживания',
      'privacyPolicy': 'Политика конфиденциальности',
      'shareMouse': 'Расскажи друзьям',
      'logout': 'Выход',
      'version': 'Версия 1.0',
      'cantLoadAccount': 'Ошибка',
      'accountIsSuspended': 'Аккаунт удален',
      'account': 'Аккаунт',
      'noMedia': 'Нет медиа',
      'upcomingShows': 'Скоро',
      'media': 'Медиа',
      'noFavorites': 'Нет избранного',
      'noCampaigns': 'Нет кампаний',
      'favorites': 'Избранное',
      'campaigns': 'Кампании',
      'followers': 'Подписчики',
      'following': 'Подписки',
      'noFollowers': 'Нет подписчиков',
      'noFollowing': 'Нет подписок',
      'success': 'Успех',
      'profileUpdated': 'Профиль был обновлен', 
      'cannotUpdate': 'Невозможно обновить',
      'usernameTaken': 'Юзернейм занят',
      'editProfile': 'Изменить профиль',
      'enterUsername': 'Ввведите юзернейм',
      'enterBio': 'Введите инфо',
      'bio': 'Инфо',
      'noRewards': 'Нет награждений',
      'noUpcomingShows': 'Нет предстоящих шоу',
      'contactInfo': 'Контактная информация',
      'fax': 'Факс',
      'officeHours': 'Часы приема', 
      'operatingHours': 'Рабочие часы', 
      'ticketsWereAdded': 'Билеты успешно добавлены', 
      'unknownError': 'Неизвестная ошибка', 
      'error': 'Ошибка', 
      'creditCard': 'Карта', 
      'paypal': 'PayPal', 
      'expiryDate': 'Дата', 
      'cvv': 'CVV', 
      'cardHolder': 'Имя владельца', 
      'pay': 'Оплатить', 
      'payWithPaypal': 'Оплатить через Paypal', 
      'paymentMethod': 'Метод оплаты', 
      'total': 'Итого', 
      'fans': 'Фанаты', 
      'artists': 'Исполнители', 
      'venues': 'Площадки', 
      'noTicketsLeft': 'Билеты закончились', 
      'pleaseSelectTickets': 'Пожалуйста, выберите билеты', 
      'emptyCart': 'Нет выбранных билетов', 
      'noTickets': 'Нет билетов', 
      'general': 'Общий', 
      'special': 'Специальный', 
      'regular': 'Обычный', 
      'soldOut': 'Нет в наличии', 
      'buyTickets': 'Купить билеты', 
      'noArtists': 'Нет исполнителей', 
      'video': 'Видео', 
      'photos': 'Фото', 
      'loading': 'Загрузка', 
      'addComment': 'Комментарий', 
      'noComments': 'Нет комментариев', 
      'showPreview': 'Информаиция о шоу', 
      'goal': 'Цель',
      'backers': 'Поддержали',
      'daysToGo': 'Осалось', 
      'finished': 'Завершено', 
      'tickets': 'Билеты', 
      'info': 'Инфо', 
      'comments': 'Комментарии', 
      'location': 'Место', 
      'otherFilters': 'Другие фильтры', 
      'noShowsFound': 'Шоу не найдены', 
      'upcoming': 'Скоро', 
      'past': 'Прошлые', 
      'follow': 'Follow', 
      'unfollow': 'Unfollow', 
      'search': 'Поиск',
      'ticket': 'Билет',
      'pleaseLogin': 'Пожалуйста, войдите для этого действия',
      'map': 'Карта',
      'yes': 'Да',
      'no': 'Нет',
      'textUSD': 'Доллары (\$)',
      'textRUB': 'Рубли (₽)',
      'textEUR': 'Евро (€)',

      'emailUpdated': 'Почта успешно изменена',
      'changeEmail': 'Старый email',
      'currentEmail': 'Текущий email',
      'update': 'Обновить',
      'passwordUpdated': 'Пароль успешно обновлен',
      'wrongCurrentPassword': 'Неверный текущий пароль',
      'changePassword': 'Сменить пароль',
      'currentPassword': 'Текущий пароль',
      'newPassword': 'Новый пароль',
      'confrimPassword': 'Подтверждение',
      'phoneUpdated': 'Номер успешно обновлен',
      'phoneAlreadyTaken': 'Номер уже занят',
      'changePhone': 'Сменить номер',
      'currentPhone': 'Текущий номер',
      'newPhone': 'Новый номер',
      'thankForQuestion': 'Спасибо за ваш вопрос!',
      'top5Questions': 'Топ 5 вопросов',
      'sendAQuestion': 'Задать вопрос',
      'howToCreateEvent': 'Как создать мероприятие',
      'createEventAnswer': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Mattis nunc sed blandit libero volutpat sed cras ornare. Volutpat sed cras ornare arcu dui. In tellus integer feugiat scelerisque varius morbi enim nunc faucibus. Elit sed vulputate mi sit amet mauris. Condimentum vitae sapien pellentesque habitant morbi tristique. Et egestas quis ipsum suspendisse. Sagittis vitae et leo duis ut diam quam nulla porttitor. Urna id volutpat lacus laoreet non curabitur gravida. Sed vulputate mi sit amet. Risus viverra adipiscing at in tellus integer feugiat scelerisque varius. Nunc mattis enim ut tellus elementum sagittis vitae. Lorem dolor sed viverra ipsum nunc aliquet bibendum. Malesuada proin libero nunc consequat. Felis eget nunc lobortis mattis. Fermentum et sollicitudin ac orci phasellus egestas tellus rutrum tellus. Vitae proin sagittis nisl rhoncus mattis rhoncus urna neque viverra. At urna condimentum mattis pellentesque id nibh tortor id. Vulputate ut pharetra sit amet aliquam id diam maecenas. Tellus at urna condimentum mattis pellentesque id nibh tortor. Nulla facilisi etiam dignissim diam. A cras semper auctor neque vitae tempus quam. ',
      'howToCreateCrowdfunding': 'Как создать краудфандинговое мероприятие',
      'createCrowdfundingAnswer': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Mattis nunc sed blandit libero volutpat sed cras ornare. Volutpat sed cras ornare arcu dui. In tellus integer feugiat scelerisque varius morbi enim nunc faucibus. Elit sed vulputate mi sit amet mauris. Condimentum vitae sapien pellentesque habitant morbi tristique. Et egestas quis ipsum suspendisse. Sagittis vitae et leo duis ut diam quam nulla porttitor. Urna id volutpat lacus laoreet non curabitur gravida. Sed vulputate mi sit amet. Risus viverra adipiscing at in tellus integer feugiat scelerisque varius. Nunc mattis enim ut tellus elementum sagittis vitae. Lorem dolor sed viverra ipsum nunc aliquet bibendum. Malesuada proin libero nunc consequat. Felis eget nunc lobortis mattis. Fermentum et sollicitudin ac orci phasellus egestas tellus rutrum tellus. Vitae proin sagittis nisl rhoncus mattis rhoncus urna neque viverra. At urna condimentum mattis pellentesque id nibh tortor id. Vulputate ut pharetra sit amet aliquam id diam maecenas. Tellus at urna condimentum mattis pellentesque id nibh tortor. Nulla facilisi etiam dignissim diam. A cras semper auctor neque vitae tempus quam. ',
      'howToSearch': 'Как найти исполнителя рядом со мной',
      'searchAnswer': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Mattis nunc sed blandit libero volutpat sed cras ornare. Volutpat sed cras ornare arcu dui. In tellus integer feugiat scelerisque varius morbi enim nunc faucibus. Elit sed vulputate mi sit amet mauris. Condimentum vitae sapien pellentesque habitant morbi tristique. Et egestas quis ipsum suspendisse. Sagittis vitae et leo duis ut diam quam nulla porttitor. Urna id volutpat lacus laoreet non curabitur gravida. Sed vulputate mi sit amet. Risus viverra adipiscing at in tellus integer feugiat scelerisque varius. Nunc mattis enim ut tellus elementum sagittis vitae. Lorem dolor sed viverra ipsum nunc aliquet bibendum. Malesuada proin libero nunc consequat. Felis eget nunc lobortis mattis. Fermentum et sollicitudin ac orci phasellus egestas tellus rutrum tellus. Vitae proin sagittis nisl rhoncus mattis rhoncus urna neque viverra. At urna condimentum mattis pellentesque id nibh tortor id. Vulputate ut pharetra sit amet aliquam id diam maecenas. Tellus at urna condimentum mattis pellentesque id nibh tortor. Nulla facilisi etiam dignissim diam. A cras semper auctor neque vitae tempus quam. ',
      'howToUploadVideo': 'Как загрузить видео',
      'uploadVideoAnswer': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Mattis nunc sed blandit libero volutpat sed cras ornare. Volutpat sed cras ornare arcu dui. In tellus integer feugiat scelerisque varius morbi enim nunc faucibus. Elit sed vulputate mi sit amet mauris. Condimentum vitae sapien pellentesque habitant morbi tristique. Et egestas quis ipsum suspendisse. Sagittis vitae et leo duis ut diam quam nulla porttitor. Urna id volutpat lacus laoreet non curabitur gravida. Sed vulputate mi sit amet. Risus viverra adipiscing at in tellus integer feugiat scelerisque varius. Nunc mattis enim ut tellus elementum sagittis vitae. Lorem dolor sed viverra ipsum nunc aliquet bibendum. Malesuada proin libero nunc consequat. Felis eget nunc lobortis mattis. Fermentum et sollicitudin ac orci phasellus egestas tellus rutrum tellus. Vitae proin sagittis nisl rhoncus mattis rhoncus urna neque viverra. At urna condimentum mattis pellentesque id nibh tortor id. Vulputate ut pharetra sit amet aliquam id diam maecenas. Tellus at urna condimentum mattis pellentesque id nibh tortor. Nulla facilisi etiam dignissim diam. A cras semper auctor neque vitae tempus quam. ',
      'howToFindArtist': 'Как найти моего любимого исполнителя',
      'findArtistAnswer': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Mattis nunc sed blandit libero volutpat sed cras ornare. Volutpat sed cras ornare arcu dui. In tellus integer feugiat scelerisque varius morbi enim nunc faucibus. Elit sed vulputate mi sit amet mauris. Condimentum vitae sapien pellentesque habitant morbi tristique. Et egestas quis ipsum suspendisse. Sagittis vitae et leo duis ut diam quam nulla porttitor. Urna id volutpat lacus laoreet non curabitur gravida. Sed vulputate mi sit amet. Risus viverra adipiscing at in tellus integer feugiat scelerisque varius. Nunc mattis enim ut tellus elementum sagittis vitae. Lorem dolor sed viverra ipsum nunc aliquet bibendum. Malesuada proin libero nunc consequat. Felis eget nunc lobortis mattis. Fermentum et sollicitudin ac orci phasellus egestas tellus rutrum tellus. Vitae proin sagittis nisl rhoncus mattis rhoncus urna neque viverra. At urna condimentum mattis pellentesque id nibh tortor id. Vulputate ut pharetra sit amet aliquam id diam maecenas. Tellus at urna condimentum mattis pellentesque id nibh tortor. Nulla facilisi etiam dignissim diam. A cras semper auctor neque vitae tempus quam. ',
      'subject': 'Тема',
      'message': 'Сообщение',
      'send': 'Отправить',
      'noSubject': 'Без темы',
      'noMessage': 'Пустое сообщение',
      'thankForFeedback': 'Спасибо за ваш отзыв!',
      'mouseTerms': 'Условия использования MOUSE',
      'mousePrivacy': 'Политика конфиденциальности MOUSE',
      'termsText': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Mattis nunc sed blandit libero volutpat sed cras ornare. Volutpat sed cras ornare arcu dui. In tellus integer feugiat scelerisque varius morbi enim nunc faucibus. Elit sed vulputate mi sit amet mauris. Condimentum vitae sapien pellentesque habitant morbi tristique. Et egestas quis ipsum suspendisse. Sagittis vitae et leo duis ut diam quam nulla porttitor. Urna id volutpat lacus laoreet non curabitur gravida. Sed vulputate mi sit amet. Risus viverra adipiscing at in tellus integer feugiat scelerisque varius. Nunc mattis enim ut tellus elementum sagittis vitae. Lorem dolor sed viverra ipsum nunc aliquet bibendum. Malesuada proin libero nunc consequat. Felis eget nunc lobortis mattis. Fermentum et sollicitudin ac orci phasellus egestas tellus rutrum tellus. Vitae proin sagittis nisl rhoncus mattis rhoncus urna neque viverra. At urna condimentum mattis pellentesque id nibh tortor id. Vulputate ut pharetra sit amet aliquam id diam maecenas. Tellus at urna condimentum mattis pellentesque id nibh tortor. Nulla facilisi etiam dignissim diam. A cras semper auctor neque vitae tempus quam. ',
      'privacyText': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Mattis nunc sed blandit libero volutpat sed cras ornare. Volutpat sed cras ornare arcu dui. In tellus integer feugiat scelerisque varius morbi enim nunc faucibus. Elit sed vulputate mi sit amet mauris. Condimentum vitae sapien pellentesque habitant morbi tristique. Et egestas quis ipsum suspendisse. Sagittis vitae et leo duis ut diam quam nulla porttitor. Urna id volutpat lacus laoreet non curabitur gravida. Sed vulputate mi sit amet. Risus viverra adipiscing at in tellus integer feugiat scelerisque varius. Nunc mattis enim ut tellus elementum sagittis vitae. Lorem dolor sed viverra ipsum nunc aliquet bibendum. Malesuada proin libero nunc consequat. Felis eget nunc lobortis mattis. Fermentum et sollicitudin ac orci phasellus egestas tellus rutrum tellus. Vitae proin sagittis nisl rhoncus mattis rhoncus urna neque viverra. At urna condimentum mattis pellentesque id nibh tortor id. Vulputate ut pharetra sit amet aliquam id diam maecenas. Tellus at urna condimentum mattis pellentesque id nibh tortor. Nulla facilisi etiam dignissim diam. A cras semper auctor neque vitae tempus quam. ',
      'newEmail': 'Новый email',
      'shareYourCode': 'Поделитесь Вашим кодом',
      'getYourFriends': 'Поделитесь кодом с Вашими друзьями для покупки билетов.',
      'moreFriends': 'Чем больше друзей вы приведете, тем больше награда.',
      'shareIn': 'Поделиться в',
      'share': 'Поделиться',
      'pleaseSelectFeedback': 'Выберите тип отзыва',
      'pleaseRate': 'Оцените наше приложение',
      'reset': 'Сброс',

      // enums

      'fan': 'Фанат',
      'artist': 'Исполнитель',
      'venue': 'Площадки',
      'vr': 'VR',
      'in_person': 'In person',
      'blues': 'Блюз',
      'children_music': 'Детская музыка',
      'classical': 'Классика',
      'country': 'Кантри',
      'electronic': 'Электроника',
      'holiday': 'Праздничная',
      'opera': 'Опера',
      'singer': 'Певец',
      'latino': 'Латина',
      'jazz': 'Джаз',
      'pop': 'Поп',
      'soul': 'Соул',
      'musicals': 'Musicals',
      'dance': 'Танцевальная',
      'world': 'Фолк',
      'hip_hop': 'Хип-хоп',
      'alternative': 'Альтернатива',
      'christian_gospel': 'Госпел',
      'rock': 'Рок',
      'vocal': 'Вокальная',
      'reggae': 'Регги',
      'easy_listening': 'Лёгкая музыка',
      'j_pop': 'J-поп',
      'enka': 'Енка',
      'anime': 'Аниме',
      'kayokyoku': 'Каёкёку',
      'k_pop': 'K-поп',
      'karaoke': 'Караоке',
      'instrumental': 'Инструментальная',
      'brazilian': 'Бразильская',
      'spoken_word': 'Spoken word',
      'disney': 'Дисней',
      'french_pop': 'Французский поп',
      'german_pop': 'Немецкий поп',
      'german_folk': 'Немецкий фолк',
      'new_age': 'Нью эйдж',

      'night_club': 'Ночной клуб',
      'concert_hall': 'Концертный холл',
      'event_space': 'Место площадки',
      'additional_room': 'Доп. комнаты',
      'theatre': 'Театр',
      'other': 'Другое',
      'stadium_arena': 'Стадион',
      'outdoor_space': 'Открытое пространство',
      'restaurant': 'Ресторан',
      'bar': 'Бар',
      'private_residence': 'Приватная резиденция',


      //fields

      'description': 'Описание',
      'address': 'Адрес',
      'phone': 'Номер',
      'about': 'Инфо',
      'user_name': 'Юзернейм',
      'display_name': 'Имя',
      'stage_name': 'Имя',
      'genre': 'Жанр',
      
      //weekdays

      'Sunday': 'Воскресенье',
      'Monday': 'Понедельник',
      'Tuesday': 'Вторник',
      'Wednesday': 'Среда',
      'Thursday': 'Четверг',
      'Friday': 'Пятница',
      'Saturday': 'Суббота',

      'sunday': 'Воскресенье',
      'monday': 'Понедельник',
      'tuesday': 'Вторник',
      'wednesday': 'Среда',
      'thursday': 'Четверг',
      'friday': 'Пятница',
      'saturday': 'Суббота',

      //months

      'September': 'Сентябрь',
      'October': 'Октябрь',
      'November': 'Ноябрь',
      'December': 'Декабрь',
      'January': 'Январь',
      'February': 'Февраль',
      'March': 'Март',
      'April': 'Апрель',
      'May': 'Май',
      'June': 'Июнь',
      'July': 'Июль',
      'August': 'Август',

      //distance

      'km': 'Км',
      'mi': 'Мили',

      //currency

      'USD': '\$',
      'EUR': '€',
      'RUB': '₽',

      //lang

      'en': 'Английский',
      'ru': 'Русский',
    },
  };

  static String get campaingToBring => words[locale]['campaingToBring'];
  static String get watchLiveShows => words[locale]['watchLiveShows'];
  static String get discoverMusic => words[locale]['discoverMusic'];
  static String get login => words[locale]['login'];
  static String get signUp => words[locale]['signUp'];
  static String get continueAsGuest => words[locale]['continueAsGuest'];
  static String get loginWith => words[locale]['loginWith'];
  static String get mouse => words[locale]['mouse'];
  static String get username => words[locale]['username'];
  static String get password => words[locale]['password'];
  static String get forgotYourPassword => words[locale]['forgotYourPassword'];
  static String get email => words[locale]['email'];
  static String get restore => words[locale]['restore'];
  static String get firstName => words[locale]['firstName'];
  static String get lastName => words[locale]['lastName'];
  static String get confirmPassword => words[locale]['confirmPassword'];
  static String get enterEmail => words[locale]['enterEmail'];
  static String get checkEmail => words[locale]['checkEmail'];
  static String get weSentInstruction => words[locale]['weSentInstruction'];
  static String get continuew => words[locale]['continue'];
  static String get profile => words[locale]['profile'];
  static String get shows => words[locale]['shows'];
  static String get emptyUsername => words[locale]['emptyUsername'];
  static String get emptyPassword => words[locale]['emptyPassword'];
  static String get serverNotRepsonding => words[locale]['serverNotRepsonding'];
  static String get pleaseTryAgain => words[locale]['pleaseTryAgain'];
  static String get ok => words[locale]['ok'];
  static String get wrongUsernameOrPass => words[locale]['wrongUsernameOrPass'];
  static String get wrongEmailFormat => words[locale]['wrongEmailFormat'];
  static String get wrongPassSize => words[locale]['wrongPassSize'];
  static String get wrongPassSymbols => words[locale]['wrongPassSymbols'];
  static String get passwordsNotMatched => words[locale]['passwordsNotMatched'];
  static String get wrongUsernameSize => words[locale]['wrongUsernameSize'];
  static String get wrongUsernameSymbols => words[locale]['wrongUsernameSymbols'];
  static String get wrongNameSize => words[locale]['wrongNameSize'];
  static String get cannotRegister => words[locale]['cannotRegister'];
  static String get emailAlreadyTaken => words[locale]['emailAlreadyTaken'];
  static String get usernameAlreadyTaken => words[locale]['usernameAlreadyTaken'];
  static String get promo => words[locale]['promo'];
  static String get startingFrom => words[locale]['startingFrom'];
  static String get buyTicket => words[locale]['buyTicket'];
  static String get unauthorized => words[locale]['unauthorized'];
  static String get funded => words[locale]['funded'];
  static String get feed => words[locale]['feed'];
  static String get unnamed => words[locale]['unnamed'];
  static String get to => words[locale]['to'];
  static String get addedImage => words[locale]['addedImage'];
  static String get addedVideo => words[locale]['addedVideo'];
  static String get changed => words[locale]['changed'];
  static String get of => words[locale]['of'];
  static String get addedGenre => words[locale]['addedGenre'];
  static String get addedNewTicket => words[locale]['addedNewTicket'];
  static String get launchedEvent => words[locale]['launchedEvent'];
  static String get noFeedUpdates => words[locale]['noFeedUpdates'];
  static String get save => words[locale]['save'];
  static String get closed => words[locale]['closed'];
  static String get dismiss => words[locale]['dismiss'];
  static String get distanceAround => words[locale]['distanceAround'];
  static String get ticketType => words[locale]['ticketType'];
  static String get venueType => words[locale]['venueType'];
  static String get appPreferences => words[locale]['appPreferences'];
  static String get regionalOptions => words[locale]['regionalOptions'];
  static String get language => words[locale]['language'];
  static String get date => words[locale]['date'];
  static String get distance => words[locale]['distance'];
  static String get dateFormat => words[locale]['dateFormat'];
  static String get currency => words[locale]['currency'];
  static String get time => words[locale]['time'];
  static String get hour12 => words[locale]['12hour'];
  static String get hour24 => words[locale]['24hour'];
  static String get feedback => words[locale]['feedback'];
  static String get tellingYou => words[locale]['tellingYou'];
  static String get aBug => words[locale]['aBug'];
  static String get anEnchancement => words[locale]['anEnchancement'];
  static String get compliment => words[locale]['compliment'];
  static String get details => words[locale]['details'];
  static String get howAreWe => words[locale]['howAreWe'];
  static String get pleaseRateUs => words[locale]['pleaseRateUs'];
  static String get loginInfo => words[locale]['loginInfo'];
  static String get phoneNumber => words[locale]['phoneNumber'];
  static String get notifications => words[locale]['notifications'];
  static String get showsAndMessages => words[locale]['showsAndMessages'];
  static String get newShowsNear => words[locale]['newShowsNear'];
  static String get newShowsFavorite => words[locale]['newShowsFavorite'];
  static String get messagesToYou => words[locale]['messagesToYou'];
  static String get showsNotificationsHistory => words[locale]['showsNotificationsHistory'];
  static String get daily => words[locale]['daily'];
  static String get weekly => words[locale]['weekly'];
  static String get monthly => words[locale]['monthly'];
  static String get settings => words[locale]['settings'];
  static String get rewards => words[locale]['rewards'];
  static String get customerSupport => words[locale]['customerSupport'];
  static String get termsOfService => words[locale]['termsOfService'];
  static String get privacyPolicy => words[locale]['privacyPolicy'];
  static String get shareMouse => words[locale]['shareMouse'];
  static String get logout => words[locale]['logout'];
  static String get version => words[locale]['version'];
  static String get cantLoadAccount => words[locale]['cantLoadAccount'];
  static String get accountIsSuspended => words[locale]['accountIsSuspended'];
  static String get account => words[locale]['account'];
  static String get noMedia => words[locale]['noMedia'];
  static String get upcomingShows => words[locale]['upcomingShows'];
  static String get media => words[locale]['media'];
  static String get noFavorites => words[locale]['noFavorites'];
  static String get noCampaigns => words[locale]['noCampaigns'];
  static String get favorites => words[locale]['favorites'];
  static String get campaigns => words[locale]['campaigns'];
  static String get followers => words[locale]['followers'];
  static String get following => words[locale]['following'];
  static String get noFollowing => words[locale]['noFollowing'];
  static String get noFollowers => words[locale]['noFollowers'];
  static String get success => words[locale]['success'];
  static String get profileUpdated => words[locale]['profileUpdated'];
  static String get cannotUpdate => words[locale]['cannotUpdate'];
  static String get usernameTaken => words[locale]['usernameTaken'];
  static String get editProfile => words[locale]['editProfile'];
  static String get enterUsername => words[locale]['enterUsername'];
  static String get enterBio => words[locale]['enterBio'];
  static String get noRewards => words[locale]['noRewards'];
  static String get noUpcomingShows => words[locale]['noUpcomingShows'];
  static String get contactInfo => words[locale]['contactInfo'];
  static String get fax => words[locale]['fax'];
  static String get officeHours => words[locale]['officeHours'];
  static String get operatingHours => words[locale]['operatingHours'];
  static String get ticketsWereAdded => words[locale]['ticketsWereAdded'];
  static String get unknownError => words[locale]['unknownError'];
  static String get error => words[locale]['error'];
  static String get creditCard => words[locale]['creditCard'];
  static String get paypal => words[locale]['paypal'];
  static String get expiryDate => words[locale]['expiryDate'];
  static String get cvv => words[locale]['cvv'];
  static String get cardHolder => words[locale]['cardHolder'];
  static String get pay => words[locale]['pay'];
  static String get payWithPaypal => words[locale]['payWithPaypal'];
  static String get paymentMethod => words[locale]['paymentMethod'];
  static String get total => words[locale]['total'];
  static String get fans => words[locale]['fans'];
  static String get artists => words[locale]['artists'];
  static String get venues => words[locale]['venues'];
  static String get noTicketsLeft => words[locale]['noTicketsLeft'];
  static String get pleaseSelectTickets => words[locale]['pleaseSelectTickets'];
  static String get emptyCart => words[locale]['emptyCart'];
  static String get noTickets => words[locale]['noTickets'];
  static String get general => words[locale]['general'];
  static String get special => words[locale]['special'];
  static String get regular => words[locale]['regular'];
  static String get soldOut => words[locale]['soldOut'];
  static String get buyTickets => words[locale]['buyTickets'];
  static String get noArtists => words[locale]['noArtists'];
  static String get video => words[locale]['video'];
  static String get photos => words[locale]['photos'];
  static String get loading => words[locale]['loading'];
  static String get addComment => words[locale]['addComment'];
  static String get noComments => words[locale]['noComments'];
  static String get showPreview => words[locale]['showPreview'];
  static String get goal => words[locale]['goal'];
  static String get backers => words[locale]['backers'];
  static String get daysToGo => words[locale]['daysToGo'];
  static String get finished => words[locale]['finished'];
  static String get tickets => words[locale]['tickets'];
  static String get info => words[locale]['info'];
  static String get comments => words[locale]['comments'];
  static String get location => words[locale]['location'];
  static String get otherFilters => words[locale]['otherFilters'];
  static String get noShowsFound => words[locale]['noShowsFound'];
  static String get upcoming => words[locale]['upcoming'];
  static String get past => words[locale]['past'];
  static String get follow => words[locale]['follow'];
  static String get unfollow => words[locale]['unfollow'];
  static String get search => words[locale]['search'];
  static String get address => words[locale]['address'];
  static String get genre => words[locale]['genre'];
  static String get bio => words[locale]['bio'];
  static String get phone => words[locale]['phone'];
  static String get ticket => words[locale]['ticket'];
  static String get pleaseLogin => words[locale]['pleaseLogin'];
  static String get map => words[locale]['map'];
  static String get yes => words[locale]['yes'];
  static String get no => words[locale]['no'];
  static String get emailUpdated => words[locale]['emailUpdated'];
  static String get changeEmail => words[locale]['changeEmail'];
  static String get currentEmail => words[locale]['currentEmail'];
  static String get update => words[locale]['update'];
  static String get passwordUpdated => words[locale]['passwordUpdated'];
  static String get wrongCurrentPassword => words[locale]['wrongCurrentPassword'];
  static String get changePassword => words[locale]['changePassword'];
  static String get currentPassword => words[locale]['currentPassword'];
  static String get newPassword => words[locale]['newPassword'];
  static String get confrimPassword => words[locale]['confrimPassword'];
  static String get phoneUpdated => words[locale]['phoneUpdated'];
  static String get phoneAlreadyTaken => words[locale]['phoneAlreadyTaken'];
  static String get changePhone => words[locale]['changePhone'];
  static String get currentPhone => words[locale]['currentPhone'];
  static String get newPhone => words[locale]['newPhone'];
  static String get thankForQuestion => words[locale]['thankForQuestion'];
  static String get top5Questions => words[locale]['top5Questions'];
  static String get sendAQuestion => words[locale]['sendAQuestion'];
  static String get howToCreateEvent => words[locale]['howToCreateEvent'];
  static String get createEventAnswer => words[locale]['createEventAnswer'];
  static String get howToCreateCrowdfunding => words[locale]['howToCreateCrowdfunding'];
  static String get createCrowdfundingAnswer => words[locale]['createCrowdfundingAnswer'];
  static String get howToSearch => words[locale]['howToSearch'];
  static String get searchAnswer => words[locale]['searchAnswer'];
  static String get howToUploadVideo => words[locale]['howToUploadVideo'];
  static String get uploadVideoAnswer => words[locale]['uploadVideoAnswer'];
  static String get howToFindArtist => words[locale]['howToFindArtist'];
  static String get findArtistAnswer => words[locale]['findArtistAnswer'];
  static String get subject => words[locale]['subject'];
  static String get message => words[locale]['message'];
  static String get send => words[locale]['send'];
  static String get noSubject => words[locale]['noSubject'];
  static String get noMessage => words[locale]['noMessage'];
  static String get thankForFeedback => words[locale]['thankForFeedback'];
  static String get mouseTerms => words[locale]['mouseTerms'];
  static String get mousePrivacy => words[locale]['mousePrivacy'];
  static String get termsText => words[locale]['termsText'];
  static String get privacyText => words[locale]['privacyText'];
  static String get newEmail => words[locale]['newEmail'];
  static String get share => words[locale]['share'];
  static String get shareYourCode => words[locale]['shareYourCode'];
  static String get getYourFriends => words[locale]['getYourFriends'];
  static String get moreFriends => words[locale]['moreFriends'];
  static String get shareIn => words[locale]['shareIn'];
  static String get wrongPhoneFormat => words[locale]['wrongPhoneFormat'];
  static String get pleaseSelectFeedback => words[locale]['pleaseSelectFeedback'];
  static String get pleaseRate => words[locale]['pleaseRate'];
  static String get reset => words[locale]['reset'];

  static String translateEnum(String word){
    if (words[locale].containsKey(word)){
      return words[locale][word];
    } else {
      return words[locale]['other'];
    }
  }
}