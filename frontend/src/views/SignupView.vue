<script setup>
  import { zodResolver } from "@primevue/forms/resolvers/zod";
  import { z } from "zod";

  import { Form } from "@primevue/forms";
  import InputText from "primevue/inputtext";
  import Password from "primevue/password";
  import Button from "primevue/button";
  import Message from "primevue/message";

  const initialValues = {
    organizationName: "",
    email: "",
    password: "",
    passwordConfirmation: "",
  };

  const resolver = zodResolver(
    z
      .object({
        organizationName: z.string().min(1, "Organization name is required."),
        email: z.email("Enter a valid email."),
        password: z.string().min(8, "Password must be at least 8 characters."),
        passwordConfirmation: z.string().min(1, "Confirm your password."),
      })
      .refine((data) => data.password === data.passwordConfirmation, {
        message: "Passwords do not match",
        path: ["passwordConfirmation"],
      })
  );

  // TODO
  async function onSubmit({ valid, values }) {}
</script>

<template>
  <main class="max-w-md mx-auto p-6">
    <Form
      v-slot="$form"
      :initial-values="initialValues"
      :resolver="resolver"
      @submit="onSubmit"
      class="space-y-4"
    >
      <h1 class="text-3xl text-center mb-8">
        Get started with Proto!
      </h1>

      <div>
        <label for="organizationName">Organization Name</label>
        <InputText id="organizationName" name="organizationName" fluid />
        <Message
          v-if="$form.organizationName?.invalid"
          severity="error"
          size="small"
          variant="simple"
        >
          {{ $form.organizationName.error.message }}
        </Message>
      </div>

      <div>
        <label for="email">Email</label>
        <InputText id="email" name="email" type="email" fluid />
        <Message
          v-if="$form.email?.invalid"
          severity="error"
          size="small"
          variant="simple"
        >
          {{ $form.email.error.message }}
        </Message>
      </div>

      <div>
        <label for="password">Password</label>
        <Password
          id="password"
          name="password"
          toggleMask
          :feedback="false"
          fluid
        />
        <Message
          v-if="$form.password?.invalid"
          severity="error"
          size="small"
          variant="simple"
        >
          {{ $form.password.error.message }}
        </Message>
      </div>

      <div>
        <label for="passwordConfirmation">Confirm Password</label>
        <Password
          id="passwordConfirmation"
          name="passwordConfirmation"
          toggleMask
          :feedback="false"
          fluid
        />
        <Message
          v-if="$form.passwordConfirmation?.invalid"
          severity="error"
          size="small"
          variant="simple"
        >
          {{ $form.passwordConfirmation.error.message }}
        </Message>
      </div>

      <Button
        type="submit"
        label="Create Organization & Account"
        fluid
      />

      <!--TODO -- perhaps have UI for server errors, success, and loading
      submission-->
    </Form>
  </main>
</template>