# PG Flow

A comprehensive Flutter mobile application for PG (Pay Guest) owners and tenants to manage PG operations efficiently. The app provides role-based access with different features for owners and tenants.

## 🚀 Features

### 👥 Tenant Features
- **Authentication**: Phone/Email OTP login via Supabase
- **Profile Management**: View and update personal information
- **Rent Tracking**: View monthly rent and payment status
- **Complaints**: Submit and track complaints (Wi-Fi, water, maintenance, etc.)
- **Notices**: Submit notice to vacate with auto 30-day logic
- **Emergency Contacts**: Quick access to PG owner and emergency numbers
- **Payment Integration**: Optional Razorpay integration for rent payments

### 🏢 Owner Features
- **Dashboard**: Overview of all PGs, tenants, and rent collection status
- **PG Management**: Add, edit, and manage multiple PG properties
- **Tenant Management**: Add, edit, delete tenants with room assignments
- **Rent Collection**: Track rent payments and generate reports
- **Complaint Management**: View and resolve tenant complaints
- **Broadcast Messages**: Send notifications to all tenants
- **Notice Tracking**: Monitor tenant notice submissions
- **Analytics**: View occupancy rates and financial reports

## 🛠 Tech Stack

- **Frontend**: Flutter (Dart)
- **Backend**: Supabase (PostgreSQL, Auth, Storage, Realtime)
- **State Management**: Riverpod
- **Local Storage**: Hive
- **Push Notifications**: Firebase Cloud Messaging
- **Payment**: Razorpay (Optional)
- **UI**: Material Design 3 with Google Fonts

## 📱 Platform Support

- ✅ Android (Primary)
- 🔄 iOS (Future)
- 🌐 Web (Optional)

## 🏗 Project Structure

```
lib/
├── core/                    # App-wide utilities and configurations
│   └── supabase_config.dart
├── models/                  # Data models with Hive support
│   ├── user_model.dart
│   ├── pg_model.dart
│   ├── tenant_model.dart
│   ├── bill_model.dart
│   └── complaint_model.dart
├── screens/                 # UI screens
│   ├── auth/               # Authentication screens
│   ├── tenant/             # Tenant-specific screens
│   ├── owner/              # Owner-specific screens
│   └── shared/             # Shared screens
├── services/               # Business logic and API services
├── providers/              # Riverpod state management
├── widgets/                # Reusable UI components
└── utils/                  # Helper functions and utilities
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.8.0 or higher)
- Dart SDK (3.8.0 or higher)
- Android Studio / VS Code
- Supabase account
- Firebase account (for push notifications)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd pg_manager_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Set up Supabase**
   - Create a new Supabase project
   - Run the SQL schema provided in `supabase_schema.sql`
   - Get your Supabase URL and anon key

4. **Configure environment variables**
   Create a `.env` file in the project root:
   ```env
   SUPABASE_URL=your_supabase_url
   SUPABASE_ANON_KEY=your_supabase_anon_key
   ```

5. **Set up Firebase (Optional)**
   - Create a Firebase project
   - Add your `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
   - Configure Firebase Cloud Messaging

6. **Generate code**
   ```bash
   dart run build_runner build
   ```

7. **Run the app**
   ```bash
   flutter run
   ```

## 🗄 Database Schema

The app uses the following Supabase tables:

### Core Tables
- **users**: User authentication and profile data
- **pgs**: PG properties information
- **tenants**: Tenant details and room assignments
- **bills**: Rent bills and payment tracking
- **complaints**: Tenant complaints and resolutions
- **notices**: Notice to vacate submissions
- **broadcasts**: Owner broadcast messages

### SQL Schema
```sql
-- Users table
CREATE TABLE users (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  name TEXT,
  phone TEXT,
  email TEXT,
  role TEXT CHECK (role IN ('tenant', 'owner')),
  pg_id UUID REFERENCES pgs(pg_id),
  room_no TEXT
);

-- PGs table
CREATE TABLE pgs (
  pg_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  owner_id UUID REFERENCES users(id),
  pg_name TEXT,
  address TEXT
);

-- Additional tables...
```

## 🔐 Authentication

The app uses Supabase Auth with the following features:
- Email/Password authentication
- Phone OTP authentication
- Role-based access control
- JWT token management

## 📊 State Management

The app uses Riverpod for state management with the following providers:
- **AuthProvider**: User authentication state
- **UserProvider**: Current user data
- **PGProvider**: PG properties data
- **TenantProvider**: Tenant management
- **BillProvider**: Rent and billing data
- **ComplaintProvider**: Complaints management

## 🎨 UI/UX Design

- **Material Design 3**: Modern, accessible design system
- **Google Fonts**: Poppins font family
- **Color Scheme**: Blue primary color (#2563EB)
- **Responsive Design**: Works on phones and tablets
- **Dark Mode**: Future implementation

## 📱 Screenshots

### Tenant Dashboard
- Welcome section with user info
- Quick stats (rent due, days left)
- Menu grid for different features

### Owner Dashboard
- Overview of all PGs and tenants
- Quick stats (total PGs, tenants, pending rent)
- Management tools grid

## 🔧 Configuration

### Supabase Setup
1. Enable Row Level Security (RLS)
2. Configure authentication providers
3. Set up storage buckets
4. Configure realtime subscriptions

### Firebase Setup
1. Enable Cloud Messaging
2. Configure notification channels
3. Set up app signing

## 🚀 Deployment

### Android
```bash
flutter build apk --release
flutter build appbundle --release
```

### iOS (Future)
```bash
flutter build ios --release
```

## 📈 Future Enhancements

### Phase 2 Features
- **Admin Panel**: Web-based admin dashboard
- **Subscription Model**: Freemium with paid plans
- **Advanced Analytics**: Detailed reports and insights
- **Multi-language Support**: Hindi and other regional languages
- **Offline Support**: Enhanced offline capabilities
- **Payment Gateway**: Full Razorpay integration

### Technical Improvements
- **Performance**: Code optimization and caching
- **Testing**: Unit and integration tests
- **CI/CD**: Automated deployment pipeline
- **Monitoring**: Error tracking and analytics

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 📞 Support

For support and questions:
- Create an issue in the repository
- Contact the development team
- Check the documentation

## 🔄 Version History

- **v1.0.0**: Initial release with basic tenant and owner features
- **v1.1.0**: Added complaint management and notifications
- **v1.2.0**: Enhanced UI and performance improvements

---

**Built with ❤️ using Flutter and Supabase**
# pgflow
