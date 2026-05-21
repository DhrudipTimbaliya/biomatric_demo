# Simplify Application to Biometric Login Flow

This plan outlines the steps to focus the application solely on the biometric login flow, removing onboarding and registration screens, and adding dummy data to the profile page.

## Proposed Changes

### Core Configuration

#### [main.dart](file:///D:/android/project/untitled1/lib/main.dart)
- Update `initialRoute` to `/biometric`.
- Remove `/onboarding` and `/register` routes.
- Remove unnecessary imports.

### UI Components

#### [biometric_login_page.dart](file:///D:/android/project/untitled1/lib/biometric_login_page.dart)
- Remove the "Skip for Now" button as there's no other flow.
- Ensure the primary button leads to the fingerprint scan.

#### [profile_page.dart](file:///D:/android/project/untitled1/lib/profile_page.dart)
- Hardcode dummy user data (Name, Phone).
- Update the logout/back button to redirect to `/biometric`.

### Logic

#### [auth_controller.dart](file:///D:/android/project/untitled1/lib/auth_controller.dart)
- Update the `logout()` method to redirect to the `/biometric` route.

### Cleanup

#### [DELETE] [onboarding_page.dart](file:///D:/android/project/untitled1/lib/onboarding_page.dart)
#### [DELETE] [registration_page.dart](file:///D:/android/project/untitled1/lib/registration_page.dart)

## Verification Plan

### Manual Verification
- Launch the app and verify it starts at the Biometric Login page.
- Click "Enable Biometric Login" and verify it navigates to the Fingerprint Scan page.
- Complete the fingerprint scan and verify it navigates to the Profile page.
- Verify the Profile page displays the hardcoded dummy data.
- Click "Logout" and verify it returns to the Biometric Login page.
- Ensure no references to onboarding or registration remain.
